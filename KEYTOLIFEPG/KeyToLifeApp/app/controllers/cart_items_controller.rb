class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @cart = ShoppingCart.find(session[:cart_id])
    @cart_items = @cart.cart_items
  end

  def show
    respond_with(@cart_item)
  end

  def new
    @cart_item = CartItem.new
    respond_with(@cart_item)
  end

  def edit
  end

  def create
    product = params[:cart_item]
    product_id = product[:id]
    @product = Product.find(product_id)
    @cart = session[:cart_items]
    count = @cart.length
    if count == 0
      @cart << @product
      @shopping_cart = ShoppingCart.find(session[:current_cart])
      @shopping_cart.total = @product.MSRP
      @shopping_cart.customer_id = session[:user_id]
      @shopping_cart.item_count = 1
      @newItem = CartItem.create(name: @product.name, size: @product.size, sku: @product.sku, price: @product.MSRP, category_id: @product.category_id, description_id: @product.description_id, shopping_cart_id: @shopping_cart.id, weight: @product.weight)
        session[:current_cart] = @shopping_cart.id
        p @newItem
      @shopping_cart.save
    else
      @shopping_cart = ShoppingCart.find(session[:current_cart])
      if @shopping_cart.cart_items.where('sku' => "#{@product.sku}").length == 1
        @newItem = @shopping_cart.cart_items.where('sku' => @product.sku).first
        @newItem.quantity += 1
        @newItem.save
        new_quan = @newItem.quantity
        @newItem.price = new_quan * @product.MSRP
        @newItem.save
        @shopping_cart.get_total
        @shopping_cart.save
      else
      @cart << @product
      @shopping_cart.item_count = @cart.length
      items = @shopping_cart.cart_items
      @shopping_cart.total += @product.MSRP
      @newItem = CartItem.create(name: @product.name, size: @product.size, sku: @product.sku, price: @product.MSRP, category_id: @product.category_id, description_id: @product.description_id, shopping_cart_id: @shopping_cart.id, weight: @product.weight)
      @newItem
      @shopping_cart.get_total
      @shopping_cart.save
      end
    end
    @cart_items = session[:cart_items]
    respond_to do |format|
      if @newItem.save
        @total = @shopping_cart.total
        @current_cart = @shopping_cart
        format.js { flash.now[:notice] = "Successfully added to cart"}
      else
        format.js { flash[:notice] = "Item could not be added to cart"}
      end
    end
    @current_cart = @shopping_cart
  end

  def update
    @cart_item.update(cart_item_params)
    respond_with(@cart_item)
  end

  def destroy

    get_cart
    @cart = @cart_item.shopping_cart
    price = @cart_item.price
    @cart.total = @cart.total - price
    @cart.item_count -= 1
    @cart.save
    @cart_items = session[:cart_items]
    @total = @cart.total
    puts @total
    @current_cart = @cart
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to shopping_cart_path }
      format.js
    end
  end

  def update_quantity
    get_cart
    @item = CartItem.find(params[:item][:id])
    @product = Product.where('sku' => @item.sku).first
    @item.quantity = params[:item][:quantity]
    @item.price = (params[:item][:quantity]).to_i * @product.MSRP
    @item.save
    @current_cart.get_total
    @current_cart.save
    @total = @current_cart.total
    if @item.save
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private
    def get_cart
      if session[:current_cart] == nil
        @current_cart = false
      else
       @current_cart = ShoppingCart.find(session[:current_cart])
      end
      @current_cart
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params
      params[:cart_item]
    end
end

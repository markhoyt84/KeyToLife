class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  respond_to :html

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
      @shopping_cart = ShoppingCart.create(total: @product.MSRP, customer_id: session[:user_id], item_count: 1)
      @newItem = CartItem.create(name: @product.name, size: @product.size, sku: @product.sku, price: @product.MSRP, category_id: @product.category_id, description_id: @product.description_id, shopping_cart_id: @shopping_cart.id)
        session[:current_cart] = @shopping_cart.id
    else
      @cart << @product
      @shopping_cart = ShoppingCart.find(session[:current_cart])
      @shopping_cart.item_count = @cart.length
      items = @shopping_cart.cart_items
      total = @shopping_cart.total
      @shopping_cart.total += @product.MSRP
      p "*" * 100
      p @shopping_cart.item_count
      p "*" * 100
      @newItem = CartItem.create(name: @product.name, size: @product.size, sku: @product.sku, price: @product.MSRP, category_id: @product.category_id, description_id: @product.description_id, shopping_cart_id: @shopping_cart.id)
      @shopping_cart.save
    end
    @cart_items = session[:cart_items]
    respond_to do |format|
      if @newItem.save
        @current_cart = @shopping_cart
       format.js { flash[:notice] = "Successfully added to cart"}
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

    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to shopping_cart_path }
      format.js
    end
  end

  private
    def get_cart
      if session[:current_cart] == nil
        @current_cart = false
      else
       @current_cart = ShoppingCart.find(session[:current_cart])
      end
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params
      params[:cart_item]
    end
end

class ShoppingCartsController < ApplicationController
  before_action :set_shopping_cart, only: [:show, :edit, :update, :destroy]
  before_action :get_categories
  respond_to :html

  def index
    @shopping_carts = ShoppingCart.all
    respond_with(@shopping_carts)
  end

  def show
    @order = Order.new
    @current_cart = ShoppingCart.find(params[:id])
    @total = @current_cart.total
  end

  def purchase
    get_cart
    @ship_to_bill = false
    if session[:user_id] == 'guest'
      @new_order = Order.create(:total => @current_cart.total)
    else
      @customer = User.find(session[:user_id])
      @new_order = Order.create(:customer_id => @customer.id, :total => @current_cart.total)
    end
  end


  def new
    @shopping_cart = ShoppingCart.new
    @shopping_cart.
    respond_with(@shopping_cart)
  end

  def edit
  end

  def create
    get_cart
    item_id = params[:product_id]
    @cart = session[:cart_items] || session[:cart_items] = []
    @product = Product.find(item_id)
    @shopping_cart = ShoppingCart.create(shopping_cart_params)
    @cart << @product
    @shopping_cart.total = @product.MSRP
    @shopping_cart.customer_id = session[:user_id]
    @shopping_cart.item_count = 1
    @newItem = @shopping_cart.cart_items.create(name: @product.name, size: @product.size, sku: @product.sku, price: @product.MSRP, category_id: @product.category_id, description_id: @product.description_id, shopping_cart_id: @shopping_cart.id)
        session[:current_cart] = @shopping_cart.id
    respond_to do |format|
      @cart_items = session[:cart_items]
      if @shopping_cart.save
        @current_cart = @shopping_cart
        format.js { flash.now[:notice] = "Successfully added to cart"}
      else
        format.js { flash[:notice] = "Item could not be added to cart"}
      end
    end
    @current_cart = @shopping_cart
  end

  def update
    @shopping_cart.update(shopping_cart_params)
    respond_with(@shopping_cart)
  end

  def destroy
    @shopping_cart.destroy
    session[:current_cart] = nil
    session[:cart_items] = []
    respond_to do |format|
      format.html { redirect_to root_path }
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

    def set_shopping_cart
      @shopping_cart = ShoppingCart.find(params[:id])
    end

    def shopping_cart_params
      params[:shopping_cart]
    end

    def get_categories
    @categories = Category.all
  end
end

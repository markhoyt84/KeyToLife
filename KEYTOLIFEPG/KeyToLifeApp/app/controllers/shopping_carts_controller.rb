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
    @shopping_cart = ShoppingCart.new(shopping_cart_params)
    @shopping_cart.save
    respond_with(@shopping_cart)
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

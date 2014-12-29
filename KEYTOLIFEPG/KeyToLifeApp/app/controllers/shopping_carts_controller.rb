class ShoppingCartsController < ApplicationController
  before_action :set_shopping_cart, only: [:show, :edit, :update, :destroy]
  before_action :get_categories
  respond_to :html

  def index
    @shopping_carts = ShoppingCart.all
    respond_with(@shopping_carts)
  end

  def show
    @current_cart = ShoppingCart.find(params[:id])
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
    respond_with(@shopping_cart)
  end

  private
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

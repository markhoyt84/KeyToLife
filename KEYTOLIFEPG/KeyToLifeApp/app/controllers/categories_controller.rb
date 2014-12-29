class CategoriesController < ApplicationController
  before_action :get_categories, only: [:index, :show]
  before_action :get_cart


  def get_cart
    if session[:current_cart] == nil
      @current_cart = false
    else
      @current_cart = ShoppingCart.find(session[:current_cart])
    end
  end


  def index
  end

  def show
    category = Category.find(params[:id])
    if category.id == 1
      @products = category.products.where('size' => '2 oz.')
    elsif category.id == 2
      @products = category.products.where('size' => '2 oz.')
    elsif category.id == 3
      @products = category.products
    elsif category.id == 4
      @products = []
      @products << category.products.first
    elsif category.id == 5
      @products = []
      @products << category.products.first
    elsif category.id == 6
      prods = category.products
      hats = prods.find(116)
      shirts = prods.find(113)
      @products = []
      @products << hats
      @products << shirts
    end
  end

  private

  def get_categories
    @categories = Category.all
  end
end

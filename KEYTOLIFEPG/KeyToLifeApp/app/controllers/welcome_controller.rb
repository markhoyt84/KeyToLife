class WelcomeController < ApplicationController

  def get_cart
    if session[:current_cart] == nil
      @current_cart = false
      session[:cart_items] = []
    else
      @current_cart = ShoppingCart.find(session[:current_cart])
      @items = @current_cart.cart_items
    end
  end

  def index
    @subscriber = Subscriber.new
    @categories = Category.all
    if session[:user_id] == 'guest'
      if session[:current_cart] == nil
        @current_cart = false
        session[:cart_items] = []
      else
        cart_id = session[:current_cart]
        @current_cart = ShoppingCart.find(cart_id)
        @items = @current_cart.cart_items
        get_cart
      end
    elsif session[:user_id] == nil
      session[:user_id] = 'guest'
      session[:cart_items] = []
      session[:current_cart] = nil
    else
      get_cart
    end
    p session[:cart_items]
    p session[:current_cart]
  end

  def about
  end

  def search_form

  end
end

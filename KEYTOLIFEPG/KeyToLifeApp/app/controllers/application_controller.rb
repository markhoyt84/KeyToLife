class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def about
    @categories = Category.all
  end

  def add_to_session_cart
    respond_to do |format|
      format.html
      format.js
    end
    session[:cart_items]

end

end

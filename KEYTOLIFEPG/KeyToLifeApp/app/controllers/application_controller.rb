class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :new_subscriber

  def about
    @categories = Category.all
  end

  def new_subscriber
    @subscriber = Subscriber.new
  end

  def add_to_session_cart
    respond_to do |format|
      format.html
      format.js
    end
    session[:cart_items]

  end

  def search
    @categories = Category.all
    @keyword = params[:keyword].downcase
    @upkey = @keyword.capitalize!
    @descriptions = []
    @all = {}
    @proddesc = Product.all
    @products = Product.where('name LIKE ? OR name LIKE ?',"%" + @keyword + "%", "%" + @upkey + "%").all
    # @cats = Category.where(['name LIKE ?', @keyword]).all
    @categories_search = Category.where('name LIKE ? OR name LIKE ? OR description LIKE ? OR description LIKE ?', "%" + @keyword + "%", "%" + @upkey + "%", "%" + @keyword + "%", "%" + @upkey + "%").all
    @proddesc.each do |prod|
      prod.description.attributes.each do |key, value|
        if value.class == String && value.include?(@keyword || @upkeyword)
        p '&' * 100
        @descriptions << prod
      end
      end
    end
    @products_list = @products.where('size' => '2 oz.')
    p '*' * 100
    @all['products'] = @products_list
    @all['categories'] = @categories
    @all['descriptions'] = @descriptions
    p @all
  end

  def results
  end
end
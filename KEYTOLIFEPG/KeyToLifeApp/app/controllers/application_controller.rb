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
    @current_cart = ShoppingCart.find(session[:current_cart])
    @categories = Category.all
    @search_term = params[:keyword]
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
        if (value =~ /#{Regexp.escape(@keyword)}/i) != nil
        p '&' * 100
        @descriptions << prod
      end
      end
    end
    @products_list = @products.where('size' => '2 oz.')
    @descriptions.each do |prod|
      if prod.size == '2 oz.' && @products_list.include?(prod) == false
        @products_list << prod
      end
    end
    @all['products'] = @products_list
    @all['categories'] = @categories_search
    @prod_length = @all['products'].length
    @cat_length = @all['categories'].length
    @result_length = @prod_length + @cat_length
    if @result_length == 0
        flash.now[:notice] = "No Search Results Found for:" + "#{params[:keyword]}"
    end
  end
end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :new_subscriber
  def about
    @categories = Category.all
    get_cart
  end

  def new_subscriber
    @subscriber = Subscriber.new
  end

  def contact
    @categories = Category.all
    @question = Question.new
    @greenidea = Greenidea.new
    get_cart
  end

  def privacy
    @categories = Category.all
    get_cart
  end

  def search
    if session[:current_cart]
      @current_cart = ShoppingCart.find(session[:current_cart])
    end
    @categories = Category.all
    @search_term = params[:keyword]
    @keyword = params[:keyword].downcase
    @upkey = @keyword.capitalize!
    @descriptions = []
    @all = {}
    @proddesc = Product.all
    @products = Product.where('name LIKE ? OR name LIKE ?',"%" + @keyword + "%", "%" + @upkey + "%").all
    @categories_search = Category.where('name LIKE ? OR name LIKE ? OR description LIKE ? OR description LIKE ?', "%" + @keyword + "%", "%" + @upkey + "%", "%" + @keyword + "%", "%" + @upkey + "%").all
    @proddesc.each do |prod|
      prod.description.attributes.each do |key, value|
        if (value =~ /#{Regexp.escape(@keyword)}/i) != nil
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

  private
  def get_cart
      if session[:current_cart] == nil
        @current_cart = false
      else
       @current_cart = ShoppingCart.find(session[:current_cart])
      end
      @current_cart
    end
end
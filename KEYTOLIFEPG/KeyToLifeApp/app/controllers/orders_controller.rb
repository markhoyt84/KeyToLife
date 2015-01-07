class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @orders = Order.all
    respond_with(@orders)
    @current_cart = ShoppingCart.find(session[:current_cart])
  end

  def show
    @current_cart = ShoppingCart.find(session[:current_cart])
    get_categories
    @email = @order.email
    respond_with(@order)
  end

  def new
    cart_id = session[:current_cart]
    @current_cart = ShoppingCart.find(session[:current_cart])
    total = @current_cart.total
    tax = total
    @order = Order.new(:shopping_cart_id => cart_id, :user_id => current_user.id, :total => total, :first_name => current_user.first_name, :last_name => current_user.city, :billing_address => current_user.billing_address,:email => current_user.email, :billing_address_city => current_user.city, :billing_address_state => current_user.state, :billing_address_zip => current_user.zip, :telephone => current_user.telephone)
    @order.save
    get_categories
    respond_with(@order)
  end

  def edit
  end

  def payments

  end

  def create
    @current_cart = ShoppingCart.find(session[:current_cart])
    cart = session[:current_cart]
    get_categories
    @cart_info = ShoppingCart.find(cart)
    total = @cart_info.total
    if params[:order]
      @order_info = params[:order]
      @email = @order_info['email']
      @zip = @order_info['shipping_address_zip']
      @location_type = params[:location]
      @order = Order.new(:email => @email, :shipping_address_zip => @zip, :shopping_cart_id => cart, :total => total, :grand_total => total)
      @order.save
    else
    @order = Order.new(:shopping_cart_id => cart, :user_id => current_user.id, :total => total, :first_name => current_user.first_name, :last_name => current_user.last_name, :billing_address => current_user.billing_address, :billing_address_city => current_user.city, :billing_address_state => current_user.state, :billing_address_zip => current_user.zip)
    end

    respond_to do |format|
      if @order.save
        format.html {render :action => 'show'}
        format.js
      else
        format.html {render :action => 'show'}
        format.js
        p '&' * 100
      end
    end
  end

  def update
    @current_cart = ShoppingCart.find(session[:current_cart])
    get_categories
    @order.update(order_params)
    p @order.first_name
    p @order.last_name
    p @order.billing_address
    if current_user == nil
      p email = params[:user][:email]
      p password = params[:user][:password]
      if password != ""
        @user = User.create(:email => email, :password => password, :first_name => @order.first_name, :last_name => @order.last_name, :billing_address => @order.billing_address, :telephone => @order.telephone)
        sign_in @user
      end
    end
    if params[:ship_to_billing][:yes] == "1"
      @order.shipping_address_zip = @order.billing_address_zip
      @order.shipping_address_city = @order.billing_address_city
      @order.shipping_address_state = @order.billing_address_state
      @order.shipping_address = @order.billing_address
    end
    if params[:sign_up_for_newsletter][:yes] == "1"
      @subscriber = Subscriber.create(:email => params[:email])
    end
    respond_to do |format|
      if @order.save
        format.html
        format.js
      else
        format.html {render :action => 'show'}
        format.js
        p '&' * 100
      end
    end
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
  def get_categories
    @categories = Category.all
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit!
  end
end

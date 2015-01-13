require "stripe"
require 'httparty'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  include HTTParty
  Stripe.api_key = ENV['STRIPE_KEY']

  def index
    get_categories
    @orders = Order.where('user_id' => current_user.id)
    respond_with(@orders)
    if session[:current_cart]
      @current_cart = ShoppingCart.find(session[:current_cart])
    end
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
    weight = @current_cart.get_weight
    total = @current_cart.total
    if session[:order_id] == nil
      if Subscriber.where email: current_user.email != nil
        @subscribed = true
      end
      if current_user
        @card_num = current_user.retrieve_card_last_4_digit
      end
      @order = Order.new(:shopping_cart_id => cart_id, :user_id => current_user.id, :total => total, :grand_total => total, :first_name => current_user.first_name, :last_name => current_user.last_name, :billing_address => current_user.billing_address,:email => current_user.email, :billing_address_city => current_user.city, :billing_address_state => current_user.state, :billing_address_zip => current_user.zip, :telephone => current_user.telephone, :tax => @tax)
    else
      @order = Order.find(session[:order_id])
      @order.update(:shopping_cart_id => cart_id, :user_id => current_user.id, :total => total, :grand_total => total, :first_name => current_user.first_name, :last_name => current_user.last_name, :billing_address => current_user.billing_address,:email => current_user.email, :billing_address_city => current_user.city, :billing_address_state => current_user.state, :billing_address_zip => current_user.zip, :telephone => current_user.telephone, :tax => @tax)
    end
    @order.get_tax(current_user.zip)
    @order.save
    session[:order_id] = @order.id
    get_categories
    respond_with(@order)
  end

  def edit
  end

  def stripe_purchase
    @order = Order.find(params[:order][:id])
    @cart = ShoppingCart.find(@order.shopping_cart_id)
    @order_total = params[:order][:price]
    charge = params[:charge]
    user = current_user
    get_categories
    if user
      if user.stripe_customer_id == nil
        create_stripe_token(charge)
        user.create_stripe_customer(@temp_token)
        @charge = Stripe::Charge.create(
          :amount => (@order_total.to_i * 100).ceil,
          :currency => "usd",
          :customer => user.stripe_customer_id)
      else
        @charge = Stripe::Charge.create(
        :amount => (@order_total.to_i * 100).ceil,
        :currency => "usd",
        :customer => user.stripe_customer_id)
      end
    else
      create_stripe_token(charge)
      @charge = Stripe::Charge.create(
        :amount => (@order_total.to_i * 100).floor,
        :currency => "usd",
        :card => @temp_token['id'])
    end
    p'*' * 100
    p @charge
    p@charge["paid"] == true
    p'*' * 100

    if @charge["paid"] == true
        p '*' * 1000
        @cart.purchased = true
        @cart.save
        @order.save
        p session[:cart_items] = []
        p session[:current_cart] = nil
        p session[:order_id] = nil
        p session
        @current_cart = false
        redirect_to success_order_path(@order)
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
  end

  def create
    @current_cart = ShoppingCart.find(session[:current_cart])
    @weight = @current_cart.get_weight
    cart = session[:current_cart]
    get_categories
    @cart_info = ShoppingCart.find(cart)
    total = @current_cart.total
    if params[:order]
      @order_info = params[:order]
      @email = @order_info['email']
      @zip = @order_info['shipping_address_zip']
      @location_type = params[:location]
      @order = Order.new(:email => @email, :shipping_address_zip => @zip, :shopping_cart_id => cart, :total => total, :grand_total => total, :tax => @tax)
      # @order.get_tax(@zip)
      @order.save
    else
    @order = Order.new(:shopping_cart_id => cart, :user_id => current_user.id, :total => total, :first_name => current_user.first_name, :last_name => current_user.last_name, :billing_address => current_user.billing_address, :billing_address_city => current_user.city, :billing_address_state => current_user.state, :billing_address_zip => current_user.zip, :tax => @zip)
      @order.get_tax(current_user.billing_address_zip)
    end

    respond_to do |format|
      if @order.save
        session[:order_id] = @order.id
        format.html {render :action => 'show'}
        format.js
      else
        format.html {render :action => 'show'}
        format.js
        p '&' * 100
      end
    end
  end

  def success
    get_categories
    @order = Order.find(params[:id])
    @receipt_cart = ShoppingCart.find(@order.shopping_cart_id)
  end

  def cancel

  end

  def update
    @current_cart = ShoppingCart.find(session[:current_cart])
    @weight = @current_cart.get_weight
    get_categories
    @order.update(order_params)
    # if current_user && current_user.stripe_customer_id
    #   @card_num = current_user.retrieve_card_last_4_digit
    # end
    if current_user == nil
      email = params[:user][:email]
      password = params[:user][:password]
      if password != ""
        @user = User.create(:email => email, :password => password, :first_name => @order.first_name, :last_name => @order.last_name, :billing_address => @order.billing_address, :billing_address_city => @order.billing_address_city, :billing_address_zip => @order.billing_address_zip, :telephone => @order.telephone)
        sign_in @user
      end
    end
    if params[:ship_to_billing][:yes] == "1"
      @order.shipping_address_zip = @order.billing_address_zip
      @order.shipping_address_city = @order.billing_address_city
      @order.shipping_address_state = @order.billing_address_state
      @order.shipping_address = @order.billing_address
    end
    if params[:sign_up_for_newsletter] && params[:sign_up_for_newsletter][:yes] == "1"
      @subscriber = Subscriber.create(:email => params[:email])
    end
    @order.shipping_cost = @order.get_quote(@weight)
    p '*' * 100
    p @order
    p '*' * 100
    @order.get_grand_total(@order.shipping_address_zip)
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

  def get_shipping_cost(order)
    http = Net::HTTP.new("http://uone-price.unishippers.com/price/pricelink")
  end

  def create_stripe_token(charge)
    @temp_token = Stripe::Token.create(
          :card => {
          :number => charge['card_num'],
          :exp_month => charge['exp_month'],
          :exp_year => charge['exp_year'],
          :cvc => charge['cvc']
        })
  end

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

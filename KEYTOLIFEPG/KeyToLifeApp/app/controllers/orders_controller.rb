class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    get_categories
    @email = @order.email
    respond_with(@order)
  end

  def new
    @order = Order.new
    respond_with(@order)
  end

  def edit
  end

  def create
    @order_info = params[:order]
    @email = @order_info['email']
    @zip = @order_info['shipping_address_zip']
    @location_type = params[:location]
    @order = Order.new(:email => @email, :shipping_address_zip => @zip)
    p @order
    @order.save
    respond_with(@order)
  end

  def update
    @order.update(order_params)
    respond_with(@order)
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
      params[:order]
    end
end

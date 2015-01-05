class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @subscribers = Subscriber.all
    respond_with(@subscribers)
  end

  def show
    respond_with(@subscriber)
  end

  def new
    @subscriber = Subscriber.new
    respond_with(@subscriber)
  end

  def edit
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    p '*' * 100
    p @subscriber
    p '*' * 100
    respond_to do |format|
      if @subscriber.save
        format.js { flash.now[:notice] = "Successfully Subscribed"}
        p '*' * 100
        p flash[:notice]
        p '*' * 100
      else
        format.js { flash.now[:notice] = "Could not Subscribe at this time"}
        p '*' * 100
        p flash[:notice]
        p '*' * 100
      end
    end
  end

  def update
    @subscriber.update(subscriber_params)
    respond_with(@subscriber)
  end

  def destroy
    @subscriber.destroy
    respond_with(@subscriber)
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:email, :name)
    end
end

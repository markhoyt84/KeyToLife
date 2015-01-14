class GreenideasController < ApplicationController
  before_action :set_greenidea, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @greenideas = Greenidea.all
    respond_with(@greenideas)
  end

  def show
    respond_with(@greenidea)
  end

  def new
    @greenidea = Greenidea.new
    respond_with(@greenidea)
  end

  def edit
  end

  def create
    @greenidea = Greenidea.new(greenidea_params)
    @greenidea.save
    respond_with(@greenidea)
  end

  def update
    @greenidea.update(greenidea_params)
    respond_with(@greenidea)
  end

  def destroy
    @greenidea.destroy
    respond_with(@greenidea)
  end

  private
    def set_greenidea
      @greenidea = Greenidea.find(params[:id])
    end

    def greenidea_params
      params[:greenidea]
    end
end

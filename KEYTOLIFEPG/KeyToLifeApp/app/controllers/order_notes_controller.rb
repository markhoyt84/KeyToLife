class OrderNotesController < ApplicationController
  before_action :set_order_note, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @order_notes = OrderNote.all
    respond_with(@order_notes)
  end

  def show
    get_categories
    respond_with(@order_note)
  end

  def new
    @order_note = OrderNote.new
    respond_with(@order_note)
  end

  def edit
  end

  def create
    p params
    @order_note = OrderNote.new(order_note_params)
    respond_to do |format|
      if @order_note.save
        format.js { flash.now[:notice] = "Successfully added to cart"}
      else
        format.js { flash[:notice] = "Item could not be added to cart"}
      end
    end
  end

  def update
    @order_note.update(order_note_params)
    respond_with(@order_note)
  end

  def destroy
    @order_note.destroy
    respond_with(@order_note)
  end

  private
    def set_order_note
      @order_note = OrderNote.find(params[:id])
    end

    def get_categories
      @categories = Category.all
    end

    def order_note_params
      params.require(:order_note).permit(:notes, :order_id)
    end
end

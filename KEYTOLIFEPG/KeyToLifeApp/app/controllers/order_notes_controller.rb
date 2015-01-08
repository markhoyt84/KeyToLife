class OrderNotesController < ApplicationController
  before_action :set_order_note, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @order_notes = OrderNote.all
    respond_with(@order_notes)
  end

  def show
    respond_with(@order_note)
  end

  def new
    @order_note = OrderNote.new
    respond_with(@order_note)
  end

  def edit
  end

  def create
    @order_note = OrderNote.new(order_note_params)
    @order_note.save
    respond_with(@order_note)
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

    def order_note_params
      params[:order_note]
    end
end

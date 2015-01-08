require 'test_helper'

class OrderNotesControllerTest < ActionController::TestCase
  setup do
    @order_note = order_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_note" do
    assert_difference('OrderNote.count') do
      post :create, order_note: {  }
    end

    assert_redirected_to order_note_path(assigns(:order_note))
  end

  test "should show order_note" do
    get :show, id: @order_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_note
    assert_response :success
  end

  test "should update order_note" do
    patch :update, id: @order_note, order_note: {  }
    assert_redirected_to order_note_path(assigns(:order_note))
  end

  test "should destroy order_note" do
    assert_difference('OrderNote.count', -1) do
      delete :destroy, id: @order_note
    end

    assert_redirected_to order_notes_path
  end
end

require 'test_helper'

class GreenideasControllerTest < ActionController::TestCase
  setup do
    @greenidea = greenideas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:greenideas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create greenidea" do
    assert_difference('Greenidea.count') do
      post :create, greenidea: {  }
    end

    assert_redirected_to greenidea_path(assigns(:greenidea))
  end

  test "should show greenidea" do
    get :show, id: @greenidea
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @greenidea
    assert_response :success
  end

  test "should update greenidea" do
    patch :update, id: @greenidea, greenidea: {  }
    assert_redirected_to greenidea_path(assigns(:greenidea))
  end

  test "should destroy greenidea" do
    assert_difference('Greenidea.count', -1) do
      delete :destroy, id: @greenidea
    end

    assert_redirected_to greenideas_path
  end
end

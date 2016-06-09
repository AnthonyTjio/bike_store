require 'test_helper'

class KucingsControllerTest < ActionController::TestCase
  setup do
    @kucing = kucings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kucings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kucing" do
    assert_difference('Kucing.count') do
      post :create, kucing: {  }
    end

    assert_redirected_to kucing_path(assigns(:kucing))
  end

  test "should show kucing" do
    get :show, id: @kucing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kucing
    assert_response :success
  end

  test "should update kucing" do
    patch :update, id: @kucing, kucing: {  }
    assert_redirected_to kucing_path(assigns(:kucing))
  end

  test "should destroy kucing" do
    assert_difference('Kucing.count', -1) do
      delete :destroy, id: @kucing
    end

    assert_redirected_to kucings_path
  end
end

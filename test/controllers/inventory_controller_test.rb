require 'test_helper'

class InventoryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get check" do
    get :check
    assert_response :success
  end

  test "should get revise" do
    get :revise
    assert_response :success
  end

end

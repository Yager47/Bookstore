require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get address" do
    get :address
    assert_response :success
  end

  test "should get delivery" do
    get :delivery
    assert_response :success
  end

  test "should get payment" do
    get :payment
    assert_response :success
  end

  test "should get confirm" do
    get :confirm
    assert_response :success
  end

  test "should get complete" do
    get :complete
    assert_response :success
  end

end

require "test_helper"

class Api::PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get success" do
    get api_payment_success_url
    assert_response :success
  end

  test "should get failure" do
    get api_payment_failure_url
    assert_response :success
  end
end

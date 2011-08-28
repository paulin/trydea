require 'test_helper'

class MobileGatewayAuthorizedControllerTest < ActionController::TestCase
  test "should get get_user_info" do
    get :get_user_info
    assert_response :success
  end

  test "should get submit_idea" do
    get :submit_idea
    assert_response :success
  end

end

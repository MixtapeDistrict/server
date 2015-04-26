require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get showProfile" do
    get :showProfile
    assert_response :success
  end

end

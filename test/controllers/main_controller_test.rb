require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get parse_route" do
    get :parse_route
    assert_response :success
  end

end

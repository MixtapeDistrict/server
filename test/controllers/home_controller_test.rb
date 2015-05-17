require 'test_helper'

# Unit tests for the home controller 
class HomeControllerTest < ActionController::TestCase
puts "Pass"
	# Testing different actions respond correctly

	# Show home action
	test "should show home" do
		get :showHome
		assert_response :success
		puts "Pass"
	end

	# Sign up action
	test "sign up" do
		get :sign_up
		assert_response :success
		puts "Pass"
	end

	# Sign out action
	test "sign out" do
		get :sign_out
		assert_resoponse :success
		puts "Pass"
	end

	# Log in action
	test "login" do 
		get :login
		assert_response :success
		puts "Pass"

	end
end

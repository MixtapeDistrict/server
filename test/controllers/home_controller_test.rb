# Unit tests for things the homepage does:
# Signs users up, and logs them in.


# Unit tests for the home controller 
class HomeControllerTest
    # Tests whether the users can sign up properly
    def sign_up
    	puts "Testing Sign up"
    	# Create a dummy user with dummy information
    	user = User.create(username:"hitplayshare",password:"testing",email:"x@hotmail.com")
    	# Ensure the user signed up
    	raise "Failed to sign the user up " unless user
    end
end

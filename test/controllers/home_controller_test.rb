# Unit tests for things the homepage does:
# Signs users up, and logs them in.


# Unit tests for the home controller 
class HomeControllerTest
    # Tests whether the users can sign up properly
    def sign_up
    	puts "Testing Sign up"
    	# Create a dummy user with dummy information
    	user = User.create(username:"hitplayshare",password:"testing",email:"x@hotmail.com")
    	# Store the id of this user for later tests
    	@id = user.id
    	# Ensure the user signed up
    	raise "Failed to sign the user up " unless user
    	puts "Sign up test passed"
    end

    # Tests whether the user can log in
    def log_in
    	puts "Testing correct log in"
    	# Put in the username & password user signed up with
    	username = "hitplayshare"
    	password = "testing"
    	# Ensure the user can log in
    	user = User.find_by(username:username, password:password)
    	raise "Failed the log in test" unless user
    	puts "Log in correct test passed"
    	puts "Testing incorrect log in"
    	# Put in the wrong username/password
    	username = "testing2"
    	password = "hitplayshare"
    	user = User.find_by(username:username, password:password)
    	raise "Incorrect log in test failed" unless not user
    	puts "Incorrect login test passed"
    end

    # Clean up
    def clean_up
    	puts "Cleaning up..."
    	User.find_by(id:@id).destroy
    end

    # A class method which can be called to run this unit test
    def self.run
    	# Create a new test object
    	hct = HomeControllerTest.new
    	# Run the individual unit tests
    	puts "<--------------------- Running unit tests for home controller ---------------->"
    	hct.sign_up
    	hct.log_in
    	hct.clean_up
    	puts "<----------------------ALL UNIT TESTS PASSED-------------------------->"
	end
end

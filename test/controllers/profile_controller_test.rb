# On the profile user should be able to change their
# description mainly, all the other functionality
# will be tested in the web browser
class ProfileControllerTest

	# Tests whether user can successfully change their information
	def change_information
		puts "Testing edit information"
		# Create a dummy user
		user = User.create()
		@id = user.id
		# Change the user's information
		user.description = "Testing"
		user.website_link = "dummylink"
		# Persist the information
		user.save
		# Ensure the user's details updated
		user = User.find_by(id:@id)
		raise "Edit information failed" unless user.description == "Testing" and user.website_link == "dummylink"
		puts "Edit information test passed."
	end

	# Cleans up
	def clean_up
		puts "Cleaning up...."
		# Find the user
		user = User.find_by(id:@id)
		user.destroy
	end

	# A class method which runs this unit test case
	def self.run
		 puts "<--------------------- Running unit tests for profile controller ---------------->"
		 pct = ProfileControllerTest.new
		 pct.change_information
		 pct.clean_up
		 puts "<---------------------- All unit tests for profile controller passed ------------->"
	end
end

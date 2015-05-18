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

	# Testing whether the logic of users following each other works
	def follow
		puts "Testing user follow functionality"
		# Find the original user
		user = User.find_by(id:@id)
		# Create a second user
		user2 = User.create()
		@id2 = user2.id
		# Make the second user follow the first user
		user.followers.create(user_id:@id, follower_id:@id2)
		# Check that user2 follows
		raise "User follow test failed " unless user.followers.first.follower_id == @id2 and user.followers.first.user_id == @id
		puts "User follow test passed"
	end

	# Cleans up
	def clean_up
		puts "Cleaning up...."
		# Find the user
		user = User.find_by(id:@id)
		user2 = User.find_by(id:@id2)
		user.destroy
		user2.destroy
	end

	# A class method which runs this unit test case
	def self.run
		 puts "<--------------------- Running unit tests for profile controller ---------------->"
		 pct = ProfileControllerTest.new
		 pct.change_information
		 pct.follow
		 pct.clean_up
		 puts "<---------------------- All unit tests for profile controller passed ------------->"
	end
end

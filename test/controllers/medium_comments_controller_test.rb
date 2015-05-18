# Unit test cases for a medium comment
# Just tests whether the database was implemented
# appropriately.

class MediumCommentsControllerTest
	# Testing whether the user can add a comment to medium
	def add_comment
		puts "Testing comments adding"
		# Create a dummy medium
		medium = Medium.create
		@medium_id = medium.id
		# Create a dummy user
		user = User.create
		@user_id = user.id
		# Create a comment for this user
		comment = user.comments.create(comment:"Texting this", comment_type:"M")
		# Make the comment have a medium comment
		comment.medium_comment = MediumComment.create(medium_id:@medium_id)
		comment.save

		# Ensure this comment was added for this medium
		raise "Comments test failed" unless medium.medium_comments.length == 1
		puts "Comments test passed"
	end

	# Clean up
	def clean_up
		puts "Cleaning up..."
		# Destroy medium
		Medium.find_by(id:@medium_id).medium_comments.destroy_all
		Medium.find_by(id:@medium_id).destroy
		User.find_by(id:@user_id).destroy
	end

	# A class method to run this test case
	def self.run
		puts "<--------------------- Running unit tests for medium comments controller ---------------->"
		mcct = MediumCommentsControllerTest.new
		mcct.add_comment
		mcct.clean_up
    	puts "<----------------------ALL UNIT TESTS PASSED-------------------------->"
    end
end

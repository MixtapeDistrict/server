# Actions for all profile modifications and display.
# Creator: Vui Chee 
# Last modified 5th May 2015

class ProfileController < ApplicationController

	# Displays the user information from the database.
	def showProfile
		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Should fetch user's data from database and display profile details.
			userID = session['user_id']
			@userID = userID
			if userID <= 0
				render nothing: true
			end

			user = User.find(userID)

			# Get the ids of all people requesting to collaborate with you.
			@requestIDs = Collaboration.where(second_id:userID).select(:first_id)
			@num_requests = @requestIDs.count

			# Now get all requests that you make to others.
			@approved_requests = Collaboration.where(first_id:userID, approved:true)
			@approved_ids = Array.new(@approved_requests.count)

			for i in 0..@approved_requests.count - 1
				@approved_ids[i] = @approved_requests[i].second_id
			end


			if (user)
				@username = user.username
				@email = user.email
				@description = user.description
				@website_link =  user.website_link
				@image_path  = user.image_path
				@tracks = user.tracks_heard

				# Get the array of tracks that this user has uploaded
				@owntracks = Medium.getusertracks(session['user_id'])
				
				# Count the number of followers the user has.
				if Follower.where(user_id:userID).count > 0
					@num_followers = Follower.where(user_id:userID).count
				else
					@num_followers = 0
				end

				# Store an array of objects containing all following ids.
				@all_following_ids = Follower.where(follower_id:userID).select(:user_id)
				# Find all the people the user is following.
				@num_following = Follower.where(follower_id:userID).count

				# Initialize names and links arrays for people user is following.
				@names_following = Array.new(@num_following)
				@links_following = Array.new(@num_following)
				@ids = Array.new(@num_following)

				# Now get all the required data.
				for i in 0..@num_following
					if @all_following_ids[i]
						curr_id = @all_following_ids[i].user_id
						@ids[i] = curr_id
						@names_following[i] = User.find(curr_id).username
						@links_following[i] = User.find(curr_id).website_link
					end
				end

				# Now items can be rendered in the view.
			end

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end


  	# Display all followers as links.
  	def showFollowers
		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get user id.
			userID = session['user_id']

			# Count the number of followers the user has.
			if Follower.where(user_id:userID).count > 0
				@num_followers = Follower.where(user_id:userID).count
			else
				@num_followers = 0
			end

			@follower_names = Array.new(@num_followers)
			@follower_ids = Array.new(@num_followers)

			# Get the user ids of all followers.
			@ids = Follower.where(user_id:userID).select(:follower_id)

			for i in 0..@num_followers
				if @ids[i]
					curr_id = @ids[i].follower_id
					@follower_ids[i] = curr_id
					@follower_names[i] = User.find(curr_id).username
				end
			end

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end


  	# Takes user to updateProfile page where he/she update her profile details.
  	def updateProfile
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get user id.
			userID = session['user_id']

			@username = User.find(userID).username
			@email = User.find(userID).email
			@website_link = User.find(userID).website_link
			@description = User.find(userID).description

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end


  	# Updates details of user in database and redirects back to profile page.
  	def updateDetails
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get current user id.
			userID = session['user_id']	

			# Retrieve variables from form.
			new_username = params[:name]
			new_email = params[:email]
			new_link = params[:link]
			new_description = params[:description]
			new_image = params[:image]

			# Now update records if need be. Blank inputs means no update!
			if not new_username.empty?
				User.find(userID).update(username:new_username)
			end

			if not new_email.empty?
				User.find(userID).update(email:new_email)
			end

			if not new_link.empty?
				User.find(userID).update(website_link:new_link)
			end

			if not new_description.empty?
				User.find(userID).update(description:new_description)
			end
			
			if not new_image.nil?
				User.updateimage(userID, new_image)
			end

			redirect_to url_for(:controller => :profile, :action => :showProfile)

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end

  	# Allowers registered users to upload music
	def newTrack
		# Ensure user is logged in 
		if(session.has_key?("logged_in"))
			# If the user is not logged in, redirect to the homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome) and return
			end
		end

		# Get passed information
  		@uploaded_file = params['track-file']
		@uploaded_image = params['track-img']
		@track = params
		puts params
		# Check if user inputted in no file
		if(@uploaded_file.nil?)
			redirect_to url_for(:controller => :profile, :action => :showProfile) and return
		end
		filenamebase = Time.now().strftime("%Y%m%d%H%M%S")+'___'
		File.open(Rails.root.join('public/assets', 'media', filenamebase+@uploaded_file.original_filename), 'wb') do |file|
			file.write(@uploaded_file.read)
		end
		File.open(Rails.root.join('app/assets', 'media', filenamebase+@uploaded_file.original_filename), 'wb') do |file|
			file.write(@uploaded_file.read)
		end


		if(@uploaded_image.nil?)
			Medium.createnew(session['user_id'].to_i, params[:title].to_s, filenamebase+@uploaded_file.original_filename, "placeholder.gif", "music")
		else
			File.open(Rails.root.join('app/assets/images', 'mediaimage', filenamebase+@uploaded_image.original_filename), 'wb') do |file|
				file.write(@uploaded_image.read)
			end
			File.open(Rails.root.join('public/assets/images', 'mediaimage', filenamebase+@uploaded_image.original_filename), 'wb') do |file|
				file.write(@uploaded_image.read)
			end
			# Create the medium
			medium = Medium.createnew(session['user_id'].to_i, params['track-name'].to_s, filenamebase+@uploaded_file.original_filename, filenamebase+@uploaded_image.original_filename, "M")
			# Create the music which belongs to this medium
			music = Music.create(image_path:filenamebase+@uploaded_image.original_filename, plays:0, genre:params['genre'])
			# Associate this music with the medium
			medium.music = music
			medium.save
		end
		redirect_to url_for(:controller => :profile, :action => :showProfile)
  	end


  	# Show other person's profile.
  	def showOther
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in") and session['logged_in'] == 1)

			# Get your current user id if you are logged in.
			logged_in_id = session['user_id']

			# Get other person's profile details.
			user = User.find(params[:id].to_i)

			# Get other person's id.
			userID = user.id
			@userID = userID
			

			# If you are following this person, the follow button should not be visible.
			if Follower.where(user_id:userID, follower_id:logged_in_id).count > 0
				@amFollowing = true # You are following this person.
			else
				@amFollowing = false
			end

			# If you come back to your profile, you should just see your own page.
			if userID == logged_in_id
				redirect_to url_for(:controller => :profile, :action => :showProfile) and return
			end

		else

			# Get user_id from link clicked on.
			user = User.find(params[:id])

			userID = user.id

			# Do not show follow button when offline.
			@amFollowing = false

		end

		@otherID = user.id

		@username = user.username
		@email = user.email
		@description = user.description
		@website_link =  user.website_link
		@image_path  = user.image_path
		@tracks = user.tracks_heard
			
		#Get the other user's tracks
		@owntracks = Medium.getusertracks(user)


		@approved_requests = Collaboration.where(first_id:userID, approved:true)
		@approved_ids = Array.new(@approved_requests.count)

		for i in 0..@approved_requests.count - 1
			@approved_ids[i] = @approved_requests[i].second_id
		end


		# Count the number of followers the user has.
		if Follower.where(user_id:userID).count > 0
			@num_followers = Follower.where(user_id:userID).count
		else
			@num_followers = 0
		end

		# Store an array of objects containing all following ids.
		@all_following_ids = Follower.where(follower_id:userID).select(:user_id)
		# Find all the people the user is following.
		@num_following = Follower.where(follower_id:userID).count

		# Initialize names and links arrays for people user is following.
		@names_following = Array.new(@num_following)
		@links_following = Array.new(@num_following)
		@ids = Array.new(@num_following)

		# Now get all the required data.
		for i in 0..@num_following
			if @all_following_ids[i]
				curr_id = @all_following_ids[i].user_id
				@ids[i] = curr_id
				@names_following[i] = User.find(curr_id).username
				@links_following[i] = User.find(curr_id).website_link
			end
		end
		
  	end


  	# Unfollow the person you are following.
  	def unfollow
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get your id
			@userID = session['user_id']

			# Get the id of the person you want to unfollow
			@unfollow_id = params[:id]

			# Destroy record of you following this person.
			if @userID != @unfollow_id and @unfollow_id.to_i > 0
				Follower.where(user_id:@unfollow_id, follower_id:@userID).destroy_all
				redirect_to url_for(:controller => :profile, :action => :showOther, :id => @unfollow_id.to_s)
			end

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end

  	# Use this follow to follow someone.
  	def follow
		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get user id.
			userID = session['user_id']

			# Get id of person you want to follow.
			toFollowID = params[:id]

			# Check if you are currently following this person.
			if Follower.where(user_id:toFollowID, follower_id:userID).count == 0
				if userID != toFollowID and toFollowID.to_i > 0
					# Follow this person
					Follower.create(user_id:toFollowID, follower_id:userID)
					redirect_to url_for(:controller => :profile, :action => :showOther, :id => toFollowID)
					return
				end
			end

			redirect_to url_for(:controller => :profile, :action => :showOther, :id => toFollowID)
		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end

  	# Changes the user's payment email
  	def change_payment_email
  		# Ensure the user is still logged in 
  		if(session.has_key?("logged_in"))
  			if(session['logged_in']!=1)
  				redirect_to url_for(:controller => :home, :action => :showHome) and return
  			end
  		else
  			redirect_to url_for(:controller => :home, :action => :showHome) and return
  		end
  		# Get the user's new email
  		email = params[:payment_email]
  		# Find the user's database record
  		user = User.find_by(id:session['user_id'])
  		# Change their payment email
  		user.payment_email = email
  		# Save the record
  		user.save
  		# Redirect the user to their profile page
  		redirect_to url_for(:controller => :profile, :action => :showProfile) and return
  	end

end

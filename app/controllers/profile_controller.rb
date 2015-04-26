# Actions for all profile modifications and display.
# Creator: Vui Chee 
# Last modified 27th April 2015

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
			user = User.find(userID)

			if (user)
				@username = user.username
				@email = user.email
				@description = user.description
				@website_link =  user.website_link
				@image_path  = user.image_path
				@tracks = user.tracks_heard
				# Now items can be rendered in the view.
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

			redirect_to url_for(:controller => :profile, :action => :showProfile)

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
  	end

end






class CollaborationController < ApplicationController

	# Creates a request to another user to collaborate with him/her.
	def coRequest
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get user id.
			userID = session['user_id']

			# Person to collaborate with.
			@otherID = params[:co_id]

			check = Array.new(2)

			# Need to check in both ways.
			check[0] = Collaboration.where(first_id:userID, second_id:@otherID).count

			# Add request if no such request has been made.
			if  check[0] == 0
				# Generate a record for the request if there aren't any.
				Collaboration.create(first_id:userID, second_id:@otherID, approved:false)
			end

			# Stay on profile that user is currently on.
			redirect_to url_for(:controller => :profile, :action => :showOther, :id => @otherID)

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
	end

	def showRequests
  		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get user id.
			@userID = session['user_id']


			# ids of people requesting collaboration.
			@co_ids = Collaboration.where(second_id:@userID)

			@num = @co_ids.count

			# Arrays to store ids other requesters.
			@requester_ids = Array.new(@num)
			@names = Array.new(@num)

			for i in 0..@num-1
				@requester_ids[i] = @co_ids[i].first_id
				@names[i] = User.find(@co_ids[i].first_id).username
			end

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
	end

	def acceptRequest
		# Ensure user is logged in to view this page
		if(session.has_key?("logged_in"))
			# If the user is not logged in redirect to homepage
			if(session['logged_in'] != 1) 
				redirect_to url_for(:controller => :home, :action => :showHome)
			end

			# Get your user id.
			userID = session['user_id']

			# Person id to accept request
			otherID = params[:id]

			# Set approved to true.
			Collaboration.find_by(first_id:otherID, second_id:userID).update(approved:true)

			redirect_to url_for(:action => :showRequests)

		else
			redirect_to url_for(:controller => :home, :action => :showHome)
		end
	end
end


























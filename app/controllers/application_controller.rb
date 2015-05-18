# Search functionality is implemented here.
# 
# Actions(functions/methods):
# => search_results : search database for records the user is searching 
# 	 				  for.
#
# => ratings : calculate the ratings for that medium based on current
#    		   ratings.
#
# => logged_in_status : checks if user is logged in.
#
# Modified at: 18th May 2015
#########################################################################

class ApplicationController < ActionController::Base

	helper_method :ratings

	# Search action. 
	def search_results
		
		# User entered input.
		search_string = params[:search].downcase.strip

		# Get all tracks.
		allTracks = Medium.all
		numTracks = allTracks.count

		# Create a hash to store results.
		@track_results = Hash.new

		# Search for every track title with that string.
		for i in 0..numTracks-1
			if allTracks[i].title.downcase.include? search_string
				@track_results[allTracks[i].id] = allTracks[i]
			end
			if Music.find_by(medium_id:allTracks[i].id).genre.downcase.include? search_string
				@track_results[allTracks[i].id] = allTracks[i]
			end
		end

		# Get all users
		allUsers = User.all
		numUsers = allUsers.count

		@user_results = Hash.new

		# Get all users with matching usernames.
		for i in 0..numUsers-1
			if allUsers[i].username.downcase.include? search_string
				@user_results[allUsers[i].id] = allUsers[i].username
			end
		end

		# No matching results.
		if @track_results.count == 0 and @user_results.count == 0
			@no_results = true
		end
	end


    # Gets a rating for a given medium id
    def ratings(medium_id)
    	medium = Medium.first
		
  		# Get the rating for this song
  		# Calculate the average rating of this song
  		rating_count = 0
   	    rating_sum = 0
   	    user_ratings = Rating.where(medium_id:medium_id)
		
   	    # Get the average rating of every user.
    	for user_rating in user_ratings
  		    rating_sum  += user_rating.rating
  		    rating_count += 1
  	    end
		
  	    rating = 0
		
  	    if(rating_count != 0)
  	    	rating = rating_sum.to_f/rating_count
     	end
		
  	   return rating
    end
    
    # Helper method which checks whether the user is logged in or not
    # Used by certain AJAX scripts
    def logged_in_status
    	response = "#{session['logged_in']}"
    	render :text =>response and return 
    end
end

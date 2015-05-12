class ApplicationController < ActionController::Base

	helper_method :ratings
	def search_results
		
		search_string = params[:search].downcase

		allTracks = Medium.all
		numTracks = allTracks.count

		# Create a hash to store results
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

		allUsers = User.all
		numUsers = allUsers.count

		@user_results = Hash.new

		# Get all 
		for i in 0..numUsers-1
			if allUsers[i].username.downcase.include? search_string
				@user_results[allUsers[i].id] = allUsers[i].username
			end
		end

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
    


end

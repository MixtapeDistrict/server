class ApplicationController < ActionController::Base

	def search_results
		
		search_string = params[:search].downcase

		allTracks = Medium.all
		numTracks = allTracks.count

		# Create new array to store results
		@track_results = Array.new

		# Search for every track title with that string.
		for i in 0..numTracks-1
			if allTracks[i].title.downcase.include? search_string
				@track_results.push(allTracks[i])
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


end

# Playlist functionality.
#
# Responsibilities: Provides interface
# for AJAX calls to add music to playlist,
# remove music from playlist, read music
# from playlist.
#
# Modified at: 18th May 2015
#########################################################################

# Slice directory length
SLICE_LENGTH = 18

class PlaylistMusicsController < ApplicationController
	before_action :set_playlist_music, only: [:show, :edit, :update, :destroy]

	# GET /playlist_musics
	# GET /playlist_musics.json
	def index
		@playlist_musics = PlaylistMusic.all
	end

	# GET /playlist_musics/1
	# GET /playlist_musics/1.json
	def show
	end

	# GET /playlist_musics/new
	def new
		@playlist_music = PlaylistMusic.new
	end

	# GET /playlist_musics/1/edit
	def edit
	end

	# POST /playlist_musics
	# POST /playlist_musics.json
	def create
		@playlist_music = PlaylistMusic.new(playlist_music_params)

		respond_to do |format|
			if @playlist_music.save
				format.html { redirect_to @playlist_music, notice: 'Playlist music was successfully created.' }
				format.json { render action: 'show', status: :created, location: @playlist_music }
			else
				format.html { render action: 'new' }
				format.json { render json: @playlist_music.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /playlist_musics/1
	# PATCH/PUT /playlist_musics/1.json
	def update
		respond_to do |format|
			if @playlist_music.update(playlist_music_params)
				format.html { redirect_to @playlist_music, notice: 'Playlist music was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @playlist_music.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /playlist_musics/1
	# DELETE /playlist_musics/1.json
	def destroy
		@playlist_music.destroy
		respond_to do |format|
			format.html { redirect_to playlist_musics_url }
			format.json { head :no_content }
		end
	end

	# Returns XML depending on which kind of music the user has in the playlist
	def get_playlist
		# The playlist functionality will only work if you are logged in
		# Get the user id
		# If the user is not logged in, empty XML is returned
		if(session['logged_in'] != 1) 
			xml_response = "<images></images>"
			render :xml => xml_response and return
		end
		
		#Get user id
		user_id = session['user_id']
		
		# Find the user in the database
		user = User.find_by(id:user_id)
		
		# Get the playlist for this user
		playlist = user.playlist
		
		# If the user does not have a playlist already create one for it
		if(not playlist)
			user.playlist = Playlist.create()
			playlist = user.playlist
			user.save
		end
		
		# Get all the tracks images the user has in their playlist
		tracks = playlist.musics
		response = "<images>"
		
		for track in tracks
			# Put in the songID here so the user can get the image
			response += "<image>#{track.image_path}</image>" 
		end
		
		response += "</images>"
		
		# Return this response back to the caller
		render :xml => response and return
	end

	# Adds a song to the user's playlist 
	# Returns an XML representing the user's playlist 
	# after adding the song.
	def add_song
		# Ensure the user is logged in
		if(session['logged_in'] != 1)
			render :nothing => true and return
		end
		
		# Fetch the user's information
		user_id = session['user_id']
		user = User.find_by(id:user_id)
		
		# Fetch the track information
		path = params[:path]
		
		# Get their playlist
		playlist = user.playlist
		
		# If they do not have a playlist create new playlist for them
		if(not playlist)
			user.playlist = Playlist.create()
			playlist = user.playlist
			user.save
		end
		
		# Find the song to add to the playlist
		medium = Medium.find_by(file_path:path)
		
		#Grab the correct portion of the data
		if medium
			music = medium.music
		end
		
		# If there was such a song on the database, add it to the user's playlist
		# Only add this song to the playlist if it isn't already in it
		if medium and music
			if(not playlist.musics.find_by(id:music.id))
				# This is not in the user's playlist hence add it!
				playlist.musics.push(music)
				playlist.save
				user.save
			end
		end
  	
		# Return the playlist so the views can be updated using ajax
		xml = "<tracks>"
		
		#Add all the relevant fields to the XML output
		for music in playlist.musics
			xml += "<track>"
			xml += "<name>#{music.medium.title}</name>"
			xml += "<path>#{music.medium.file_path}</path>"
			xml += "<imgpath>#{music.image_path}</imgpath>"
			xml += "<artist>#{music.medium.user.username}</artist>"
			xml += "<artist_id>#{music.medium.user.id}</artist_id>"
			
			# Calculate the average rating of this song
			rating_count = 0
			rating_sum = 0
			user_ratings = Rating.where(medium_id:music.medium.id)
			
			#Add the ratings together
			for user_rating in user_ratings
				rating_sum  += user_rating.rating
				rating_count += 1
			end
		
		#Initialize rating to 0
		rating = 0
		puts rating_sum
		puts rating_count
		
		#Generate the actual rating if one exists
		if(rating_count != 0)
			rating = rating_sum.to_f/rating_count
		end
  		
		#Add the information to the XML output
		xml += "<rating>#{rating}</rating>"
  		xml += "<plays>#{music.plays}</plays>"
  		xml += "<songID>#{music.id}</songID>"
  		xml += "</track>"
	end
  	
	#Close tags and render
	xml += "</tracks>"
	render :xml => xml and return
	end

	# Returns the image of a track
	def track_image
		# Get the required parameters
		music_id = params[:music_id]
		
		# Find the music within the database
		music = Music.find_by(id:music_id)
		
		# If such a song exists return its image path
		response = "#{music.image_path}"
		render :text => response and return
	end

	# Gets the track information given its image path
	def track_info
		# Get the image path
		# Remove the preceding folders by slicing the string 
		image_path = params[:image_path].slice(SLICE_LENGTH, params[:image_path].length)
		puts image_path
		
		# Find the song with this image path
		music = Music.find_by(image_path:image_path)
		
		# Now the medium
		medium = music.medium
		
		# Find the user who made this track
		user = medium.user

		#Add fields and data to XML output
		xml  = "<song>"
		xml  += "<title>#{medium.title}</title>"
		xml  += "<songID>#{music.id}</songID>"
		xml  += "<artist>#{user.username}</artist>"
		xml  += "<artistID>#{user.id}</artistID>"
		xml  += "<filePath>#{medium.file_path}</filePath>"
		xml  += "<genre>#{music.genre}</genre>"
		xml += "<imagePath>#{image_path}</imagePath>"
		
		#If the music has been played them list the number of plays, otherwise 0
		if(music.plays)
			xml  += "<plays>#{music.plays}</plays>"
		else 
			xml  += "<plays>0</plays>"
		end
		
		# Calculate the average rating of this song
		rating_count = 0
		rating_sum = 0
		user_ratings = Rating.where(medium_id:medium.id)
		
		
		#Sum up the ratings
		for user_rating in user_ratings
			rating_sum  += user_rating.rating
			rating_count += 1
		end
		
		rating = 0
		
		#Generate the actual rating if it exists
		if(rating_count != 0)
			rating = rating_sum.to_f/rating_count
		end
		
		#Add data to XML output, close tags and render
		xml  += "<rating>#{rating}</rating>"
		xml  += "</song>"
		render :xml => xml and return
	end

	# Ajax function removes track of user
	# Then returns their playlist with their track removed
	def remove_track
		# get the music id parsed in
		music_id = params[:song_id]
		
		# If user isn't logged in return without rendering anything
		if(session['logged_in'] != 1)
			render :nothing => true and return
		end

		# Get the user_id
		user_id = session['user_id']
		
		# find the user in the database
		user = User.find_by(id:user_id)
		
		# get their playlist
		playlist = user.playlist
		
		# Get the song from their playlist
		music = playlist.musics.find_by(id:music_id)
		
		# Delete this song from their playlist
		playlist.musics.delete(music)
		
		# Persist
		playlist.save
		user.save
        # Return the playlist so the views can be updated using ajax
		xml = "<tracks>"
		
		#Rating information for all music in the playlist
		for music in playlist.musics
		
			#Add tags and data for the song
			xml += "<track>"
			xml += "<name>#{music.medium.title}</name>"
			xml += "<path>#{music.medium.file_path}</path>"
			xml += "<imgpath>#{music.image_path}</imgpath>"
			xml += "<artist>#{music.medium.user.username}</artist>"
			xml += "<artist_id>#{music.medium.user.id}</artist_id>"
			
			#Get the ratings from the database
			rating_count = 0
			rating_sum = 0
			user_ratings = Rating.where(medium_id:music.medium.id)
			
			#Sum up the ratings
			for user_rating in user_ratings
				rating_sum  += user_rating.rating
				rating_count += 1
			end
		
			rating = 0
			puts rating_sum
			puts rating_count
		
			#Generate the total rating if it exists
			if(rating_count != 0)
				rating = rating_sum.to_f/rating_count
			end
  		
			#Add the rating and plays data to the XML output
			xml += "<rating>#{rating}</rating>"
  			xml += "<plays>#{music.plays}</plays>"
  			xml += "<songID>#{music.id}</songID>"
  			xml += "</track>"
		end
		
		#Close tags and render
		xml += "</tracks>"
		render :xml => xml and return
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_playlist_music
		@playlist_music = PlaylistMusic.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def playlist_music_params
		params.require(:playlist_music).permit(:playlist_id, :media_id)
	end
end

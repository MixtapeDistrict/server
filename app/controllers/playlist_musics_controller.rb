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
  	user_id = session['user_id']
  	# Find the user in the database
  	user = User.find_by(id:user_id)
  	# Get the playlist for this user
  	playlist = user.playlist
  	# If the user does not have a playlist already create one for it
  	if(not playlist)
  		user.playlist = Playlist.create()
  		playlist = user.playlist
  		# Persist
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
  		# Persist
  		user.save
  	end
  	# Find the song to add to the playlist
  	medium = Medium.find_by(file_path:path)
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
  	# Retnder nothing as this is an AJAX call
  	render :nothing => true and return
  end

  def track_image
  	# Get the required parameters
  	music_id = params[:music_id]
  	# Find the music within the database
  	music = Music.find_by(id:music_id)
  	# If such a song exists return its image path
  	response = "#{music.image_path}"
  	render :text => response and return
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

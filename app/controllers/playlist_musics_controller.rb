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
  		xml_response = "<images><image>http://myitforum.com/myitforumwp/wp-content/uploads/2012/12/error.png</image><image>http://img2.wikia.nocookie.net/__cb20100427134246/half-life/en/images/b/b8/Error.jpg</image></images>"
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
  		response += "<image>#{track.id}</image>" 
  	end
  	response += "</images>"
  	# Return this response back to the caller
  	render :xml => response and return
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

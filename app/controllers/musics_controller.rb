class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :edit, :update, :destroy]

  # GET /musics
  # GET /musics.json
  def index
    @musics = Music.all
  end

  # GET /musics/1
  # GET /musics/1.json
  def show
  end

  # GET /musics/new
  def new
    @music = Music.new
  end

  # GET /musics/1/edit
  def edit
  end

  # POST /musics
  # POST /musics.json
  def create
    @music = Music.new(music_params)

    respond_to do |format|
      if @music.save
        format.html { redirect_to @music, notice: 'Music was successfully created.' }
        format.json { render action: 'show', status: :created, location: @music }
      else
        format.html { render action: 'new' }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /musics/1
  # PATCH/PUT /musics/1.json
  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to @music, notice: 'Music was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music.destroy
    respond_to do |format|
      format.html { redirect_to musics_url }
      format.json { head :no_content }
    end
  end

  # Returns XML representing tracks to load from the database
  def get_tracks
  	# Get all songs in the database
  	musics = Music.all
  	music = "<songs>"
  	for music in musics
  		# Get the medium this music belongs to
  		medium = music.medium
  		# Get the user who created the music
  		user = medium.user
  		# Add useful information to the XML 
  		music += "<song>"
  		music += "<title>#{medium.title}</title>"
  		music += "<songID>#{music.id}</songID>"
  		music += "<artist>#{user.username}</artist>"
  		music += "<artistID>#{user.id}</artistID>"
  		music += "<imagePath>#{music.image_path}"
  		music += "<filePath>#{medium.file_path}</filepath>"
  		# Check if this music belongs to an album
  		if(music.music_albums.first)
  			music += "<album>#{music.music_albums.first.title}</album>"
  			music += "<albumID>#{music.music_albums.first.id}</albumID>"
  		else
  			music += "<album></album>"
  		end
  		music += "<plays>#{music.plays}</plays>"
  		# Calculate the average rating of this song
  		rating_count = 0
  		rating_sum = 0
  		user_mediums = UserMedium.where(medium_id:medium.id)
  		for user_medium in user_mediums
  			rating_sum += user_medium.rating
  		end
  		rating = 0
  		if(rating_count != 0)
  			rating = rating_sum.to_f/rating_count
  		end
  		music += "<rating>#{rating}</rating>"
  		music += "</song>"
	end
	music += "</songs>"
	render :xml => music
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_params
      params.require(:music).permit(:image_path, :media_id, :plays, :genre)
    end
end
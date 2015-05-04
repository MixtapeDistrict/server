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
  	musics = Music.all.order('created_at DESC')
  	xml = "<songs>"
  	for music in musics
  		# Get the medium this music belongs to
  		medium = music.medium
  		# Get the user who created the music
  		user = medium.user
  		# Add useful information to the XML 
  		xml  = "<song>"
  		xml  = "<title>#{medium.title}</title>"
  		xml  = "<songID>#{music.id}</songID>"
  		xml  = "<artist>#{user.username}</artist>"
  		xml  = "<artistID>#{user.id}</artistID>"
  		xml  = "<imagePath>#{music.image_path}</imagePath>"
  		xml  = "<filePath>#{medium.file_path}</filePath>"
  		# Check if this music belongs to an album
  		if(music.music_albums.first)
  			xml  = "<album>#{music.music_albums.first.title}</album>"
  			xml  = "<albumID>#{music.music_albums.first.id}</albumID>"
  		else
  			xml  = "<album>Single</album>"
  		end
  		xml  = "<plays>#{music.plays}</plays>"
  		# Calculate the average rating of this song
  		rating_count = 0
  		rating_sum = 0
  		user_ratings = medium.ratings
  		for user_rating in user_ratings
  			rating_sum  = user_medium.rating
  		end
  		rating = 0
  		if(rating_count != 0)
  			rating = rating_sum.to_f/rating_count
  		end
  		xml  = "<rating>#{rating}</rating>"
  		xml  = "</song>"
	end
	xml  += "</songs>"
	render :xml => xml
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
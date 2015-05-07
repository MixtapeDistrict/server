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
  	musics = Music.all.order('created_at DESC').limit(100)
  	xml = "<songs>"
  	for music in musics
  		# Get the medium this music belongs to
  		medium = music.medium
  		# Get the user who created the music
  		user = medium.user
  		# Add useful information to the XML 
  		xml  += "<song>"
  		if(medium.title)
  			xml  += "<title>#{medium.title}</title>"
  		else 
  			xml  += "<title>-</title>"
  		end
  		xml  += "<songID>#{music.id}</songID>"
  		xml  += "<artist>#{user.username}</artist>"
  		xml  += "<artistID>#{user.id}</artistID>"
  		if(medium.image_path)
  			xml  += "<imagePath>#{medium.image_path}</imagePath>"
  		else
  			xml  += "<imagePath>-</imagePath>"
  		end
  		if(medium.file_path)
  			xml  += "<filePath>#{medium.file_path}</filePath>"
  		else
  			xml  += "<filePath>-</filePath>"
  		end
  		# Check if this music belongs to an album
  		if(music.music_albums.first)
  			xml  += "<album>#{music.music_albums.first.title}</album>"
  			xml  += "<albumID>#{music.music_albums.first.id}</albumID>"
  		else
  			xml  += "<album>Single</album>"
  			xml += "<albumID>-</albumID>"
  		end
  		if(music.plays)
  			xml  += "<plays>#{music.plays}</plays>"
  		else 
  			xml  += "<plays>0</plays>"
  		end
  		# Calculate the average rating of this song
  		rating_count = 0
  		rating_sum = 0
  		user_ratings = Rating.where(medium_id:medium.id)
  		for user_rating in user_ratings
  			rating_sum  += user_rating.rating
  			rating_count += 1
  		end
  		rating = 0
  		puts rating_sum
  		puts rating_count
  		if(rating_count != 0)
  			rating = rating_sum.to_f/rating_count
  		end
  		xml  += "<rating>#{rating}</rating>"
  		xml  += "</song>"
	end
	xml  += "</songs>"
	render :xml => xml
  end

<<<<<<< HEAD
=======
  # Is called when music is played. Updates plays in database (AJAX call)
  def play
  	# Get the path of the song which got played
  	path = params[:path]
  	# Find the song in the database
  	medium = Medium.find_by(file_path:path)
  	if(medium)
  		song = medium.music
  	end
  	# Increment its plays and end the transaction 
    song.plays += 1
  	song.save
  	# Render nothing to improve website performance
  	render :nothing => true
  end

  # Comments for music
  def comments
  	# Get the music ID
  	@music_id = params[:id]
  	# Find the song within the database
  	@song = Music.find_by(id:@music_id)
  	# Store the Medium
  	@medium = @song.medium
  	# Find the creator of this song
  	@creator = User.find_by(id:@medium.user_id)
  	# Get the rating for this song
  	# Calculate the average rating of this song
  	rating_count = 0
    rating_sum = 0
    user_ratings = Rating.where(medium_id:@medium.id)
  	for user_rating in user_ratings
  		rating_sum  += user_rating.rating
  		rating_count += 1
  	end
  	@rating = 0
  	if(rating_count != 0)
  		@rating = rating_sum.to_f/rating_count
  	end
  	# Store all the comments for this song
  	@medium_comments = MediumComment.where(medium_id:@medium.id)
  end

  # Adds comment + updates/initializes rating for user
  def add_comment 
  	# Ensure you are logged in 
  	if(session.has_key?("logged_in"))
	# If the user is not logged in redirect to homepage
		if(session['logged_in'] != 1) 
			redirect_to url_for(:controller => :home, :action => :showHome) and return
		end
	else
		redirect_to url_for(:controller => :home, :action => :showHome) and return
	end
  	# Parse the input which user submitted
  	comment = params[:comment]
  	rating = params[:rating]
  	user_id = session['user_id']
  	medium_id = params[:medium_id]
  	medium = Medium.find_by(id:medium_id)

  	# Check if this user has rated this medium before
  	current_rating = Rating.where(medium_id:medium_id).find_by(user_id:user_id)
  	# If this exists update the existing rating
  	if current_rating
  		current_rating.rating = rating
  		current_rating.save
  	# Otherwise create a rating for the user for this medium
  	else
  		medium.ratings.create(user_id:user_id, rating:rating)
  	end
  	# Add the comment of the user to the database
  	user = User.find_by(id:user_id)
  	new_comment = user.comments.create(comment:comment)
  	new_comment.medium_comment = medium.medium_comments.create()
  	new_comment.save
  	# Rerender the page
  	redirect_to url_for(:controller => :musics, :action => :comments, :id => medium.music.id) and return

  end

>>>>>>> origin/master
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
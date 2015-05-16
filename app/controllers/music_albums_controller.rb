class MusicAlbumsController < ApplicationController
	before_action :set_music_album, only: [:show, :edit, :update, :destroy]

	# GET /music_albums
	# GET /music_albums.json
	def index
		@music_albums = MusicAlbum.all
	end

	# GET /music_albums/1
	# GET /music_albums/1.json
	def show
	end

	# GET /music_albums/new
	def new
		@music_album = MusicAlbum.new
	end

	# GET /music_albums/1/edit
	def edit
	end

	# POST /music_albums
	# POST /music_albums.json
	def create
		@music_album = MusicAlbum.new(music_album_params)

		respond_to do |format|
			if @music_album.save
				format.html { redirect_to @music_album, notice: 'Music album was successfully created.' }
				format.json { render action: 'show', status: :created, location: @music_album }
			else
				format.html { render action: 'new' }
				format.json { render json: @music_album.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /music_albums/1
	# PATCH/PUT /music_albums/1.json
	def update
		respond_to do |format|
			if @music_album.update(music_album_params)
				format.html { redirect_to @music_album, notice: 'Music album was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @music_album.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /music_albums/1
	# DELETE /music_albums/1.json
	def destroy
		@music_album.destroy
		respond_to do |format|
			format.html { redirect_to music_albums_url }
			format.json { head :no_content }
		end
	end

	private
    
	# Use callbacks to share common setup or constraints between actions.
	def set_music_album
		@music_album = MusicAlbum.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def music_album_params
		params.require(:music_album).permit(:media_id, :album_id)
	end
end

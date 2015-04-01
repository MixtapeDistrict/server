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

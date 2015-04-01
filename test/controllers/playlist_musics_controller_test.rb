require 'test_helper'

class PlaylistMusicsControllerTest < ActionController::TestCase
  setup do
    @playlist_music = playlist_musics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playlist_musics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playlist_music" do
    assert_difference('PlaylistMusic.count') do
      post :create, playlist_music: { media_id: @playlist_music.media_id, playlist_id: @playlist_music.playlist_id }
    end

    assert_redirected_to playlist_music_path(assigns(:playlist_music))
  end

  test "should show playlist_music" do
    get :show, id: @playlist_music
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @playlist_music
    assert_response :success
  end

  test "should update playlist_music" do
    patch :update, id: @playlist_music, playlist_music: { media_id: @playlist_music.media_id, playlist_id: @playlist_music.playlist_id }
    assert_redirected_to playlist_music_path(assigns(:playlist_music))
  end

  test "should destroy playlist_music" do
    assert_difference('PlaylistMusic.count', -1) do
      delete :destroy, id: @playlist_music
    end

    assert_redirected_to playlist_musics_path
  end
end

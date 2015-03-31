json.array!(@playlist_musics) do |playlist_music|
  json.extract! playlist_music, :id, :playlist_id, :music_id
  json.url playlist_music_url(playlist_music, format: :json)
end

json.array!(@music_albums) do |music_album|
  json.extract! music_album, :id, :media_id, :album_id
  json.url music_album_url(music_album, format: :json)
end

json.array!(@musics) do |music|
  json.extract! music, :id, :image_path, :media_id, :plays, :genre
  json.url music_url(music, format: :json)
end

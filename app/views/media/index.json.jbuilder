json.array!(@media) do |medium|
  json.extract! medium, :id, :user_id, :title, :file_path, :image_path, :downloads, :media_type
  json.url medium_url(medium, format: :json)
end

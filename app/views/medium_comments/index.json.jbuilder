json.array!(@medium_comments) do |medium_comment|
  json.extract! medium_comment, :id, :comment_id, :medium_id
  json.url medium_comment_url(medium_comment, format: :json)
end

json.extract! post, :id, :name, :publish, :created_at, :updated_at
json.url topic_post_url(post, format: :json)

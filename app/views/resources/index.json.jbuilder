json.array!(@resources) do |resource|
  json.extract! resource, :name, :description, :file, :url, :user_id
  json.url resource_url(resource, format: :json)
end

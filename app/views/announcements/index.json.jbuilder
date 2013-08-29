json.array!(@announcements) do |announcement|
  json.extract! announcement, :title, :content, :level, :notify, :user_id
  json.url announcement_url(announcement, format: :json)
end

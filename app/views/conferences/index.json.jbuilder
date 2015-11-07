json.array!(@conferences) do |conference|
  json.extract! conference, :id, :name, :date, :time, :description
  json.url conference_url(conference, format: :json)
end

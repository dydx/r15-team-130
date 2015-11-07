json.array!(@conferences) do |conference|
  json.extract! conference, :id, :name, :date, :time, :description, :address, :longitude, :latitude
  json.url conference_url(conference, format: :json)
end

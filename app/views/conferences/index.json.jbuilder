json.array!(@conferences) do |conference|
  json.extract! conference, :id, :name, :dateandtime, :description, :address, :longitude, :latitude
  json.url conference_url(conference, format: :json)

end

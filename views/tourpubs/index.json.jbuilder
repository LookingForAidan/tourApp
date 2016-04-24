json.array!(@tourpubs) do |tourpub|
  json.extract! tourpub, :id, :fname, :lname, :email, :description, :date, :cost
  json.url tourpub_url(tourpub, format: :json)
end

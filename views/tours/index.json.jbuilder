json.array!(@tours) do |tour|
  json.extract! tour, :id, :fname, :lname, :email, :description, :date, :cost
  json.url tour_url(tour, format: :json)
end

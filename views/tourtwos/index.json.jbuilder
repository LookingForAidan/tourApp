json.array!(@tourtwos) do |tourtwo|
  json.extract! tourtwo, :id, :fname, :lname, :email, :description, :date, :cost
  json.url tourtwo_url(tourtwo, format: :json)
end

json.array!(@questions) do |question|
  json.extract! question, :id, :question_title
  json.url question_url(question, format: :json)
end

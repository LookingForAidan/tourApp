json.array!(@answers) do |answer|
  json.extract! answer, :id, :answer_message, :blog_id
  json.url answer_url(answer, format: :json)
end

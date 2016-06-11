json.array!(@predictions) do |prediction|
  json.extract! prediction, :id, :match_id, :user_id, :mainscore1, :mainscore2
  json.url prediction_url(prediction, format: :json)
end

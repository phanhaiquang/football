json.array!(@matches) do |match|
  json.extract! match, :id, :team1_id, :team2_id, :time, :status, :mainscore1, :mainscore2, :subscore1, :subscore2
  json.url match_url(match, format: :json)
end

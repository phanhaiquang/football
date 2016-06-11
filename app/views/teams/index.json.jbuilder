json.array!(@teams) do |team|
  json.extract! team, :id, :name, :score, :status, :coach
  json.url team_url(team, format: :json)
end

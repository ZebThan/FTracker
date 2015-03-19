json.array!(@matches) do |match|
  json.extract! match, :id, :player_red_id, :player_blue_id, :player_red_score, :player_blue_score
  json.url match_url(match, format: :json)
end

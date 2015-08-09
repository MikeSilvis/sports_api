class SportsApi::Model::Score
  SCORE_STATES = [
    PREGAME = 'pregame',
    INPROGRESS = 'in-progress',
    FINAL = 'final'
  ]

  attr_accessor :game_date,
                :league,
                :espnid,
                :line,
                :state,
                :home_team,
                :away_team,
                :home_team_score,
                :away_team_score,
                :ended_in
end

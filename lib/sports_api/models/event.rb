class SportsApi::Model::Event
  SCORE_STATES = [
    PREGAME = 'pregame',
    INPROGRESS = 'in-progress',
    FINAL = 'final'
  ]

  attr_accessor :date,
                :league,
                :espnid,
                :line,
                :state,
                :competitors
end

## TODO
# Attributes
# attendance
# Leaders

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
                :competitors,
                :status,
                :score,
                :headline

  def score
    @score ||= competitors.map { |c| c.score }.join(' - ')
  end
end

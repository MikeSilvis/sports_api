class SportsApi::Fetcher::Boxscore::MLB < SportsApi::Fetcher::Boxscore
  def score_fetcher
    @score_fetcher ||= SportsApi::Fetcher::Score::MLB.find(event_date)
  end

  def generate_score_detail
  end

  def markup
    @markup ||= get('mlb/boxscore', gameId: gameid)
  end
end

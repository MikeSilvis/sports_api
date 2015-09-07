class SportsApi::Fetcher::Calendar
  def self.find(league, gameid)
    case league
    when SportsApi::NCF
      SportsApi::Fetcher::Calendar::NFL.find(gameid)
    when SportsApi::NCF
      SportsApi::Fetcher::Calendar::NCF.find(gameid)
    when SportsApi::NBA
      SportsApi::Fetcher::Calendar::NBA.find(gameid)
    when SportsApi::MLB
      SportsApi::Fetcher::Calendar::MLB.find(gameid)
    end
  end
end

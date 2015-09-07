class SportsApi::Fetcher::Calendar
  def self.find(league)
    case league
    when SportsApi::NCF
      SportsApi::Fetcher::Calendar::NFL.find
    when SportsApi::NCF
      SportsApi::Fetcher::Calendar::NCF.find
    when SportsApi::NBA
      SportsApi::Fetcher::Calendar::NBA.find
    when SportsApi::MLB
      SportsApi::Fetcher::Calendar::MLB.find
    end
  end
end

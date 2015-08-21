class SportsApi::Fetcher::Calendar::NBA < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NBA.find(Date.today).calendar
  end
end

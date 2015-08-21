class SportsApi::Fetcher::Calendar::NFL < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NFL.find(1, 1).calendar
  end
end

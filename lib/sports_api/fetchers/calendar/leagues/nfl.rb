class SportsApi::Fetcher::Calendar::NFL < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NFL.find_by(1, 1).calendar
  end
end

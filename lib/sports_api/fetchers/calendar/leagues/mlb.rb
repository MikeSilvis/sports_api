class SportsApi::Fetcher::Calendar::MLB < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::MLB.find(Date.today).calendar
  end
end

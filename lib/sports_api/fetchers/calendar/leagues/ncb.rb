class SportsApi::Fetcher::Calendar::NCB < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NCB.find(Date.today).calendar
  end
end

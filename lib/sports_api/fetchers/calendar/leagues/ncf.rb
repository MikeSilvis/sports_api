class SportsApi::Fetcher::Calendar::NCF < SportsApi::Fetcher::Calendar
  def self.find
    SportsApi::Fetcher::Score::NCF.find_by(1).calendar
  end
end

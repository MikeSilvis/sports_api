class SportsApi::Fetcher::Score
  attr_accessor :date,
                :week

  def self.find(league, date)
    case league
    when SportsApi::NFL
      SportsApi::Fetcher::Score::NFL.find(date)
    when SportsApi::NCF
      SportsApi::Fetcher::Score::NCF.find(date)
    when SportsApi::NBA
      SportsApi::Fetcher::Score::NBA.find(date)
    when SportsApi::NCB
      SportsApi::Fetcher::Score::NCB.find(date)
    when SportsApi::MLB
      SportsApi::Fetcher::Score::MLB.find(date)
    end
  end
end

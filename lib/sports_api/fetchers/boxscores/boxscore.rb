class SportsApi::Fetcher::Boxscore
  attr_accessor :gameid

  def initialize(gameid)
    self.gameid = gameid
  end

  def self.find(gameid)
    new(gameid).response
  end
end

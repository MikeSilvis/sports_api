class SportsApi::Fetcher::Boxscore
  include SportsApi::Fetcher::ESPN::Scraper
  attr_accessor :gameid

  def initialize(gameid)
    self.gameid = gameid
  end

  def self.find(league, gameid)
    case league
    when SportsApi::NFL
      SportsApi::Fetcher::Boxscore::NFL.find(gameid)
    when SportsApi::NCF
      SportsApi::Fetcher::Boxscore::NCF.find(gameid)
    when SportsApi::NBA
      SportsApi::Fetcher::Boxscore::NBA.find(gameid)
    when SportsApi::MLB
      SportsApi::Fetcher::Boxscore::MLB.find(gameid)
    end
  end

  def response
    SportsApi::Model::Boxscore.new.tap do |boxscore|
      boxscore.score = score
      boxscore.score_details = generate_score_detail
    end
  end

  def score
    @score ||= score_fetcher.events.detect do |event|
      event.gameid == gameid
    end
  end

  def event_date
    @event_date ||= Date.parse(markup.at_css('.game-time-location p').content)
  end
end

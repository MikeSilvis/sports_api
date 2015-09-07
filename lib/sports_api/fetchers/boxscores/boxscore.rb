class SportsApi::Fetcher::Boxscore
  include SportsApi::Fetcher::ESPN::Scraper
  attr_accessor :gameid

  def initialize(gameid)
    self.gameid = gameid
  end

  def gameid=(gameid)
    @gameid = gameid.to_i
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
      boxscore.event = event
      boxscore.score_details = generate_score_detail
      boxscore.location = location
    end
  end

  def event
    @event ||= score_fetcher.events.detect do |event|
      event.gameid == gameid
    end
  end

  def event_date
    @event_date ||= DateTime.parse(markup.at_css('.game-date-time span').attributes['data-date'].value)
  end

  private

  def location
    @location ||= begin
                    div = markup.at_css('.game-field .caption-wrapper')
                    div ? div.content.strip : nil
                  end
  end
end

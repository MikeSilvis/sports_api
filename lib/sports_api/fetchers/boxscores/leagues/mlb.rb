class SportsApi::Fetcher::Boxscore::MLB < SportsApi::Fetcher::Boxscore

  def self.find(date)
    new(date).response
  end

  private

  def score_fetcher
    @score_fetcher ||= SportsApi::Fetcher::Score::MLB.find(event_date)
  end

  def generate_score_detail
    Array(SportsApi::Model::ScoreDetail.new.tap do |score_detail|
      score_detail.contents = generate_score_details
    end)
  end

  def generate_score_details
    table = markup.css('.mod-container.mod-open.mod-open-gamepack')[4]
    table.css('tbody tr.even, tr.odd').map do |row|
      SportsApi::Model::ScoreDetailContent.new.tap do |detail_content|
        detail_content.time = row.css('td')[1].content
        detail_content.detail = row.css('td')[2].content

        css_klass = row.css('td')[0].at_css('div').attributes['class'].value.match(/mlb-small-\d*/).to_s
        detail_content.competitor = css_klass == home_klass ? event.competitors.first : event.competitors.last
      end
    end
  end

  def home_klass
    get_klass(2)
  end

  def away_klass
    get_klass(0)
  end

  def get_klass(position)
    markup.css('.team-color-strip')[position].at_css('th div').attributes['class'].value.match(/mlb-small-\d*/).to_s
  end

  def event_date
    @event_date ||= Date.parse(markup.at_css('.game-time-location p').content)
  end

  def markup
    @markup ||= get('mlb/boxscore', gameId: gameid)
  end
end

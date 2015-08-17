class SportsApi::Fetcher::Boxscore::NFL < SportsApi::Fetcher::Boxscore
  include SportsApi::Fetcher::ESPN::Scraper
  attr_accessor :event_date

  def response
    SportsApi::Model::Boxscore.new.tap do |boxscore|
      boxscore.score = score
      boxscore.score_details = generate_score_detail
    end
  end

  private

  def event_date
    @event_date ||= Date.parse(markup.at_css('.game-time-location p').content)
  end

  def score
    @score ||= score_fetcher.events.detect do |event|
                 event.gameid == gameid
               end
  end

  def generate_score_detail
    table = markup.at_css('.mod-container.mod-open.mod-open-gamepack')
    table.css('thead').each_with_index.map do |header, index|
      SportsApi::Model::ScoreDetail.new.tap do |score_detail|
        score_detail.headline = header.at_css('th').content
        score_detail.contents = table.css('tbody')[index].css('tr').map do |content_html|
          SportsApi::Model::ScoreDetailContent.new.tap do |detail_content|
            detail_content.time = content_html.css('td')[2].content
            detail_content.detail = content_html.css('td')[3].content

            markdown_abbr = content_html.css('td')[0].at_css('img').attributes['alt'].value
            competitor = score.competitors.detect { |comp| comp.abbreviation.downcase == markdown_abbr}
            detail_content.competitor = competitor
          end
        end
      end
    end
  end

  def score_fetcher
    @score_fetcher ||= SportsApi::Fetcher::Score::NFL.find(date_list.season, date_list.week)
  end

  def date_list
    calendar.dates.detect do |list|
      (list.start_date < event_date) && (event_date < list.end_date)
    end
  end

  def calendar
    @calendar ||= SportsApi::Fetcher::Score::NFL.find(1, 1).calendar
  end

  def markup
    @markup ||= get('nfl/boxscore', gameId: gameid)
  end
end

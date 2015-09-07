class SportsApi::Fetcher::Boxscore::NCF < SportsApi::Fetcher::Boxscore

  def self.find(gameid)
    new(gameid).response
  end

  private

  def generate_score_detail
    score_details_array.map do |detail|
      SportsApi::Model::ScoreDetail.new.tap do |score_detail|
        score_detail.headline = detail[:header_info]
        score_detail.contents = detail[:content_info].map do |content|
          SportsApi::Model::ScoreDetailContent.new.tap do |detail_content|
            detail_content.competitor   = event.competitors.detect { |competitor| competitor.id.match(/#{content[0]}/i) }
            detail_content.time         = content[1]
            detail_content.detail       = content[2]
          end
        end
      end
    end
  end

  def score_details_array
    @score_details_array ||= self.event.status.pregame? ? [] : SportsApi::Fetcher::Helpers::ScoreDetailFinder.new(markup).details
  end

  def score_fetcher
    @score_fetcher ||= SportsApi::Fetcher::Score::NCF.find(event_date)
  end

  def markup
    @markup ||= get('ncf/game', gameId: gameid)
  end
end

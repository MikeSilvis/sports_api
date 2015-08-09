class SportsApi::Fetcher::Score::NBA < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  def response
    SportsApi::Model::League.new.tap do |league|
      league_json = json['leagues'].first

      league.name = league_json['name']
      league.abbreviation = league_json['abbreviation']
      league.calendar_type = league_json['calendarType']
      league.calendar = league_json['calendar'].map { |date| Date.parse(date) }
    end
  end

  private

  def json
   @json ||= get('basketball', 'nba', date)
  end
end

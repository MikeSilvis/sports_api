class SportsApi::Fetcher::Score::MLB < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  def response
    generate_league
  end

  private

  def json
    @json ||= get('baseball', 'mlb', date)
  end
end

require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::MLB < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(date)
    self.date = date
  end

  def self.find(date)
    new(date).response
  end

  private

  def generate_calendar(calendar_json)
    generate_calendar_day(calendar_json)
  end

  def json
    @json ||= get('baseball', 'mlb', dates: date.to_s.gsub(/[^\d]+/, '').to_i)
  end

  def league
    SportsApi::MLB
  end
end

require_relative '../helpers/api_parser'

class SportsApi::Fetcher::Score::NCF < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(week)
    self.week = week
  end

  def self.find(date)
    date_obj = date_list(date)

    date_obj ? SportsApi::Fetcher::Score::NCF.find_by(date_obj.week) : nil
  end

  def self.find_by(week)
    new(week).response
  end

  def response
    generate_league
  end

  def self.league
    SportsApi::NCF
  end

  def league
    self.class.league
  end

  private

  def generate_calendar(calendar_json)
    generate_calendar_list(calendar_json)
  end

  def json
    @json ||= get('football', 'college-football', week: week, limit: 300, groups: 80)
  end
end

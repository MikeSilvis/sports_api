class SportsApi::Fetcher::Score::NCF < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api
  include SportsApi::Fetcher::Score::ApiParser

  def initialize(week)
    self.week = week
  end

  def self.find(week)
    new(week).response
  end

  def response
    generate_league
  end

  private

  def generate_calendar(calendar_json)
    calendar_json.map do |category_json|
      next unless category_json['entries']

      category_json['entries'].map do |schedule_json|
        SportsApi::Model::Schedule::List.new.tap do |schedule|
          schedule.category = category_json['label']

          schedule.label = schedule_json['label']
          schedule.detail = schedule_json['detail']
          schedule.value = schedule_json['value']
          schedule.start_date = Date.parse(schedule_json['startDate'])
          schedule.end_date = Date.parse(schedule_json['endDate'])
        end
      end
    end.flatten
  end

  def json
    @json ||= get('football', 'college-football', week: week)
  end
end

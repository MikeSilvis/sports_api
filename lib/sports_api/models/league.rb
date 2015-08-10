class SportsApi::Model::League
  CALENDAR_TYPES = [
    DAY = 'day',
    LIST = 'list'
  ]

  attr_accessor :name,
                :abbreviation,
                :calendar_type,
                :calendar,
                :events

  def calendar=(dates)
    @calendar ||= SportsApi::Model::Schedule::Day.new(dates)
  end
end

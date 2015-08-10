class SportsApi::Fetcher::Score::NBA < SportsApi::Fetcher::Score
  include SportsApi::Fetcher::ESPN::Api

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

  def generate_league
    SportsApi::Model::League.new.tap do |league|
      league_json = json['leagues'].first

      ## Build League
      league.name = league_json['name']
      league.abbreviation = league_json['abbreviation']
      league.calendar_type = league_json['calendarType']
      league.calendar = league_json['calendar'].map { |date| Date.parse(date) }

      ## Build Event
      league.events = generate_events
    end
  end

  def generate_events
    json['events'].map do |event_json|
      SportsApi::Model::Event.new.tap do |event|
        event.date = Date.parse(event_json['date'])
        event.status = generate_status(event_json)
        event.competitors = generate_competitors(event_json)
      end
    end
  end

  def generate_status(event_json)
    status_json = event_json['status']

    SportsApi::Model::Status.new.tap do |status|
      status.display_clock = status_json['displayClock']
      status.period = status_json['period']
      status.state = status_json['type']['state']
      status.detail = status_json['type']['shortDetail']
    end
  end

  def generate_competitors(event_json)
    event_json['competitions'].first['competitors'].map do |competitor_json|
      SportsApi::Model::Competitor.new.tap do |competitor|
        competitor.type = competitor_json['type']
        competitor.home_away = competitor_json['homeAway']
        competitor.score = competitor_json['score']
        competitor.winner = competitor_json['winner']

        competitor.name = competitor_json['team']['displayName']
        competitor.abbreviation = competitor_json['team']['abbreviation']
        competitor.location = competitor_json['team']['location']

        competitor.record = generate_record(competitor_json['records'].first)
      end
    end
  end

  def generate_record(record_json)
    SportsApi::Model::Record.new.tap do |record|
      record.name = record_json['name']
      record.summary = record_json['summary']
    end
  end

  def json
    @json ||= get('basketball', 'nba', date)
  end
end

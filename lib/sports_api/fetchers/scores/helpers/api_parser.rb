module SportsApi::Fetcher::Score::ApiParser
  attr_accessor :league

  def response
    generate_league
  end

  def generate_league
    SportsApi::Model::League.new.tap do |league|
      league_json = json['leagues'].first

      ## Build League
      league.name = league_json['name']
      league.abbreviation = league_json['abbreviation']
      league.calendar_type = league_json['calendarType']
      league.calendar = generate_calendar(league_json['calendar'])

      ## Build Event
      league.events = generate_events
    end
  end

  def generate_calendar(calendar_json)
    raise 'To be overriden'
  end

  def generate_calendar_day(calendar_json)
    calendar_json.map { |date| SportsApi::Model::Schedule::Day.new(Date.parse(date)) }
  end

  def generate_calendar_list(calendar_json)
    calendar_json.map do |category_json|
      next unless category_json['entries']

      category_json['entries'].map do |schedule_json|
        SportsApi::Model::Schedule::List.new.tap do |schedule|
          schedule.category = category_json['label']
          schedule.season = category_json['value']
          schedule.label = schedule_json['label']
          schedule.detail = schedule_json['detail']
          schedule.week = schedule_json['value']
          schedule.start_date = Date.parse(schedule_json['startDate'])
          schedule.end_date = Date.parse(schedule_json['endDate'])
        end
      end
    end.flatten.compact
  end

  def generate_events
    json['events'].map do |event_json|
      SportsApi::Model::Event.new.tap do |event|
        event.date = Date.parse(event_json['date'])
        event.gameid = event_json['id']
        event.league = self.league

        event.status = generate_status(event_json)
        event.competitors = generate_competitors(event_json)
        event.headline = generate_headline(event_json['competitions'].first['headlines'].to_a.first.to_h)
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
        competitor.linescores = competitor_json['linescores'].to_a.map { |l| l['value'] }
        competitor.winner = competitor_json['winner']

        competitor.name = competitor_json['team']['displayName']
        competitor.abbreviation = competitor_json['team']['abbreviation']
        competitor.location = competitor_json['team']['location']
        competitor.id = competitor_json['team']['id']

        competitor.record = generate_record((competitor_json['records'] || []).first)
        competitor.rank = (competitor_json['curatedRank'] || {})['current']
      end
    end
  end

  def generate_record(record_json)
    record_json = record_json || {}

    SportsApi::Model::Record.new.tap do |record|
      record.name = record_json['name']
      record.summary = record_json['summary']
    end
  end

  def generate_headline(headline_json)
    SportsApi::Model::Headline.new.tap do |headline|
      video_json = headline_json['video'].to_a.first.to_h

      headline.title = video_json.empty? ? headline_json['description'] : video_json['headline']
      headline.content = headline_json['description']
      headline.photo = video_json['thumbnail']
    end
  end
end

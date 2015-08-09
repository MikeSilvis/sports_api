require 'byebug'
Dir["#{File.dirname(__FILE__)}/sports_api/**/**/*.rb"].sort_by(&:length).reject { |file| file.match(/version/) }.each { |f| load(f) }

module SportsApi
  LEAGUES = [
    NHL = 'nhl',
    NBA = 'nba',
    NCF = 'ncf',
    MLB = 'mlb',
    NFL = 'nfl',
    NCB = 'ncb'
  ]
  def self.root
    File.expand_path('../..',__FILE__)
  end
end

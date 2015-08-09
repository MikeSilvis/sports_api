require 'faraday'
require 'nokogiri'

module SportsApi::Fetcher
  module ESPN
    def url(*path)
      path.map { |p| p.gsub!(/\A\//, '') }
      subdomain = (path.first == 'scores') ? path.shift : nil
      domain = [subdomain, 'espn', 'go', 'com'].compact.join('.')
      ['http:/', domain, *path].join('/')
    end

    # Returns Nokogiri HTML document
    # Ex: ESPN.get('teams', 'nba')
    def get(*path)
      http_url = self.url(*path)
      response = Faraday.get(http_url, timeout: 10)
      if response.status == 200
        Nokogiri::HTML(response.body)
      else
        raise ArgumentError, error_message(url, path)
      end
    end
  end
end

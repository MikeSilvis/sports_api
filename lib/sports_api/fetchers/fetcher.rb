require 'faraday'
require 'nokogiri'
require 'json'

module SportsApi::Fetcher
  module ESPN
    module Api
      def get(league_string, league, date)
        response = Http.get("http://site.api.espn.com/apis/site/v2/sports/#{league_string}/#{league}/scoreboard?dates=#{date}")
        if response.status == 200
          JSON.parse(response.body)
        else
          raise ArgumentError, error_message(url, path)
        end
      end
    end

    module Scraper
      def url(*path)
        path.map { |p| p.gsub!(/\A\//, '') }
        subdomain = (path.first == 'scores') ? path.shift : nil
        domain = [subdomain, 'espn', 'go', 'com'].compact.join('.')
        ['http:/', domain, *path].join('/')
      end

      def get(*path)
        http_url = self.url(*path)
        response = Http.get(http_url)
        if response.status == 200
          Nokogiri::HTML(response.body)
        else
          raise ArgumentError, error_message(url, path)
        end
      end
    end
  end

  class Http
    attr_accessor :body,
      :status

    def initialize(status, body)
      self.status = status
      self.body   = body
    end

    def self.get(url)
      response = Faraday.get(url, timeout: 10)
      new(response.status, response.body)
    end
  end
end

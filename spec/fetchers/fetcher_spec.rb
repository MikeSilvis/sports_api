require 'spec_helper'

class DummyApiClass
  include SportsApi::Fetcher::ESPN::Api
end

class DummyScraperClass
  include SportsApi::Fetcher::ESPN::Scraper
end

describe SportsApi::Fetcher do
  describe 'new' do
    let(:response) { Faraday::Response.new }
    before { expect(response).to receive(:status).and_return(200) }
    context 'api class' do
      let(:league_string) { 'football' }
      let(:league) { SportsApi::NFL }
      let(:date) { Date.today }
      let(:expected_url) { "http://site.api.espn.com/apis/site/v2/sports/#{league_string}/#{league}/scoreboard?dates=20150809" }
      before do
        expect(response).to receive(:body).and_return({name: 'Mike Silvis'}.to_json)
        expect(Faraday).to receive(:get).with(expected_url, {timeout: 10}).and_return(response)
      end
      it { expect(DummyApiClass.new.get(league_string, league, '20150809')['name']).to eq('Mike Silvis') }
    end
    context 'scraper class' do
      before do
        expect(response).to receive(:body).and_return('<html><body><h1>Hi Mike</h1></body></html>')
        expect(Faraday).to receive(:get).with('http://scores.espn.go.com', {timeout: 10}).and_return(response)
      end
      it { expect(DummyScraperClass.new.get('scores').at_css('h1').content).to eq("Hi Mike") }
    end
  end
end

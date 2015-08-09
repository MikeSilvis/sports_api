require 'spec_helper'

class DummyTestClass
  include SportsApi::Fetcher::ESPN
end

describe SportsApi::Fetcher do
  describe 'new' do
    let(:response) { Faraday::Response.new }
    before do
      expect(response).to receive(:status).and_return(200)
      expect(response).to receive(:body).and_return('<html><body><h1>Hi Mike</h1></body></html>')
      expect(Faraday).to receive(:get).with('http://scores.espn.go.com', {timeout: 10}).and_return(response)
    end
    it { expect(DummyTestClass.new.get('scores').at_css('h1').content).to eq("Hi Mike") }
  end
end

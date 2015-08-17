require 'spec_helper'

describe SportsApi::Fetcher::Boxscore::MLB do
  describe '#find' do
    let(:gameid) { 350816114 }
    let(:json_stub) { StubbedJson.get('postgame.json') }
    let(:html_stub) { StubbedHtml.get('400791773.html') }
    let(:find) { SportsApi::Fetcher::Boxscore::MLB.find(gameid) }
    before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', dates: 20150816).and_return(json_stub) }

    context 'event info' do
      it { expect(find.score.date).to eq(Date.new(2015, 8, 16)) }
    end
  end
end

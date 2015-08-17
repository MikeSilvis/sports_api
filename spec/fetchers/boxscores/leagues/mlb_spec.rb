require 'spec_helper'

describe SportsApi::Fetcher::Boxscore::MLB do
  describe '#find' do
    let(:gameid) { 350816114 }
    let(:json_stub) { StubbedJson.get('postgame.json') }
    let(:html_stub) { StubbedHtml.get('350816114.html') }
    let(:find) { SportsApi::Fetcher::Boxscore::MLB.find(gameid) }
    before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', dates: 20150816).and_return(json_stub) }
    before { expect_any_instance_of(SportsApi::Fetcher::Boxscore::MLB).to receive(:get).with('mlb/boxscore', gameId: gameid).and_return(html_stub) }

    context 'event info' do
      let(:score_detail) { find.score_details.first }
      it { expect(find.score.date).to eq(Date.new(2015, 8, 16)) }
      it { expect(find.score_details.count).to eq(1) }
      it { expect(score_detail.headline).to eq(nil) }
      it { expect(score_detail.contents.first.detail).to eq('Donaldson singled to right, Tulowitzki scored.') }
      it { expect(score_detail.contents.first.competitor.abbreviation).to eq('TOR') }
    end
  end
end

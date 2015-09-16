require 'spec_helper'

describe SportsApi::Fetcher::Boxscore::NCF do
  describe '#find' do
    let(:gameid) { 400763398 }
    let(:find) { SportsApi::Fetcher::Boxscore::NCF.find(gameid) }
    let(:json_stub_week_1) { StubbedJson.get('postgame-week-1.json') }
    let(:html_stub) { StubbedHtml.get("#{gameid}.html") }
    let(:expect_instance) { allow_any_instance_of(SportsApi::Fetcher::Score::NCF) }
    before { expect_instance.to receive(:get).with('football', 'college-football', week: 1, limit: 300, groups: 80).and_return(json_stub_week_1) }
    before { expect_instance.to receive(:get).with('football', 'college-football', week: 1, limit: 300, groups: 80).and_return(json_stub_week_1) }
    before { expect_any_instance_of(SportsApi::Fetcher::Boxscore::NCF).to receive(:get).with('ncf/game', gameId: gameid).and_return(html_stub) }

    context 'event info' do
      let(:score_detail) { find.score_details.first }
      it { expect(find.event.date.to_date).to eq(Date.new(2015, 9, 4)) }
      it { expect(find.score_details.count).to eq(4) }
      it { expect(score_detail.headline).to eq('First Quarter') }
      it { expect(score_detail.contents.first.detail).to eq('Jaden Oberkrom 53 yd FG GOOD') }
      it { expect(score_detail.contents.first.competitor.abbreviation).to eq('TCU') }
    end
  end
end

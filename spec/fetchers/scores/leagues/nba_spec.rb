require 'spec_helper'

describe SportsApi::Fetcher::Score::NBA do
  describe '#find' do
    context 'past game' do
      let(:date) { Date.new(2015, 4, 19) }
      let(:find) { SportsApi::Fetcher::Score::NBA.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NBA).to receive(:get).with('basketball', 'nba', day: '20150419').and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.size).to eq(227) }
        it { expect(find.name).to eq('National Basketball Association') }
      end
      context 'event info' do
        let(:event) { find.events.first }
        it { expect(event.date).to eq(Date.new(2015, 4, 19)) }
        it { expect(event.competitors.first.name).to eq('Cavaliers') }
        it { expect(event.competitors.first.record.summary).to eq('53-29') }
        it { expect(event.score).to eq('113 - 100') }
      end
    end
  end
end


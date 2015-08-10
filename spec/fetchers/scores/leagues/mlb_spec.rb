require 'spec_helper'

describe SportsApi::Fetcher::Score::MLB < SportsApi::Fetcher::Score do
  it { expect(SportsApi::Fetcher::Score::MLB.new(Date.today)).to_not eq(nil) }
  describe '#find' do
    context 'past game' do
      let(:date) { Date.new(2015, 8, 9) }
      let(:find) { SportsApi::Fetcher::Score::MLB.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', date).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.dates.size).to eq(36) }
        it { expect(find.name).to eq('Major League Baseball') }
      end
      context 'event info' do
        let(:event) { find.events.first }
        it { expect(event.date).to eq(Date.new(2015, 8, 9)) }
        it { expect(event.competitors.first.name).to eq('New York Yankees') }
        it { expect(event.competitors.first.record.summary).to eq('61-49') }
      end
    end
  end
end

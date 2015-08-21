require 'spec_helper'

describe SportsApi::Fetcher::Score::NCF do
  it { expect(SportsApi::Fetcher::Score::NCF.new(1)).to_not eq(nil) }
  describe '#find' do
    describe 'pregame' do
      let(:week) { 1 }
      let(:find) { SportsApi::Fetcher::Score::NCF.find_by(week) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NCF).to receive(:get).with('football', 'college-football', week: week).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.size).to eq(16) }
        it { expect(find.name).to eq('NCAA - Football') }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.date).to eq(Date.new(2015, 9, 04)) }
        it { expect(event.competitors.first.name).to eq('Utah State Aggies') }
        it { expect(event.competitors.first.record.summary).to eq('0-0') }
        it { expect(event.score).to eq('0 - 0') }
      end
    end
  end
end



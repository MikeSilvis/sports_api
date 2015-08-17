require 'spec_helper'

describe SportsApi::Fetcher::Score::MLB do
  describe '#find' do
    describe 'past game' do
      let(:date) { Date.new(2015, 8, 9) }
      let(:find) { SportsApi::Fetcher::Score::MLB.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', day: '20150809').and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.dates.size).to eq(36) }
        it { expect(find.name).to eq('Major League Baseball') }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.final? } }
        it { expect(event.date).to eq(Date.new(2015, 8, 9)) }
        it { expect(event.competitors.first.name).to eq('New York Yankees') }
        it { expect(event.competitors.first.record.summary).to eq('61-49') }
        it { expect(event.score).to eq('0 - 2') }
        it { expect(event.status.final?).to be_truthy }
      end
    end

    describe 'inprogress' do
      let(:date) { Date.new(2015, 8, 9) }
      let(:find) { SportsApi::Fetcher::Score::MLB.find(date) }
      let(:json_stub) { StubbedJson.get('inprogress.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', day: '20150809').and_return(json_stub) }

      context 'event' do
        let(:event) { find.events.detect { |event| event.status.inprogress? } }
        it { expect(event.status.display_clock).to eq('0:00') }
        it { expect(event.status.period).to eq(4) }
        it { expect(event.status.detail).to eq('Mid 4th') }
      end
    end

    describe 'pregame' do
      let(:date) { Date.new(2015, 8, 10) }
      let(:find) { SportsApi::Fetcher::Score::MLB.find(date) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::MLB).to receive(:get).with('baseball', 'mlb', day: '20150810').and_return(json_stub) }

      context 'event' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.status.display_clock).to eq('0:00') }
        it { expect(event.status.period).to eq(0) }
        it { expect(event.status.detail).to eq("8/10 - 7:10 PM EDT") }
        it { expect(event.status.start_time).to eq(Time.new(2015, 8, 10, 16, 10)) }
      end
    end
  end
end

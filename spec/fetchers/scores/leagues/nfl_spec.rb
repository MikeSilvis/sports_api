require 'spec_helper'

describe SportsApi::Fetcher::Score::NFL < SportsApi::Fetcher::Score do
  it { expect(SportsApi::Fetcher::Score::NFL.new(1)).to_not eq(nil) }
  describe '#find' do
    describe 'pregame' do
      let(:week) { 1 }
      let(:find) { SportsApi::Fetcher::Score::NFL.find(week) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NFL).to receive(:get).with('football', 'nfl', week: week).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.dates.size).to eq(28) }
        it { expect(find.name).to eq('National Football League') }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.date).to eq(Date.new(2015, 9, 11)) }
        it { expect(event.competitors.first.name).to eq('New England Patriots') }
        it { expect(event.competitors.first.record.summary).to eq('0-0') }
        it { expect(event.score).to eq('0 - 0') }
      end
    end

    describe 'inprogress' do
      let(:week) { 1 }
      let(:find) { SportsApi::Fetcher::Score::NFL.find(week) }
      let(:json_stub) { StubbedJson.get('inprogress.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NFL).to receive(:get).with('football', 'nfl', week: week).and_return(json_stub) }
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.inprogress? } }
        it { expect(event.date).to eq(Date.new(2015, 8, 10)) }
        it { expect(event.competitors.first.name).to eq('Minnesota Vikings') }
        it { expect(event.competitors.first.record.summary).to eq('0-0') }
        it { expect(event.score).to eq('7 - 3') }
      end
    end
  end
end



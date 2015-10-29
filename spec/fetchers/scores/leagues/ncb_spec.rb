require 'spec_helper'

describe SportsApi::Fetcher::Score::NCB do
  describe '#find' do
    describe 'postgame' do
      let(:date) { Date.new(2015, 4, 07) }
      let(:find) { SportsApi::Fetcher::Score::NCB.find(date) }
      let(:json_stub) { StubbedJson.get('postgame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NCB).to receive(:get).with('basketball', 'mens-college-basketball', dates: 20150407, limit: 200).and_return(json_stub) }
      context 'basic league info' do
        it { expect(find.calendar.size).to eq(140) }
        it { expect(find.name).to eq("NCAA Men's Basketball") }
      end
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.final? } }
        it { expect(event.date.to_date).to eq(Date.new(2015, 4, 07)) } #UTC time places this game on the 28th
        it { expect(event.competitors.first.location).to eq('Duke') }
        it { expect(event.competitors.first.name).to eq('Blue Devils') }
        it { expect(event.competitors.first.record.summary).to eq('29-4') }
        it { expect(event.score).to eq('68 - 63') }
        it { expect(event.status.final?).to be_truthy }
      end
    end

    describe 'pregame' do
      let(:date) { Date.new(2015, 11, 13) }
      let(:find) { SportsApi::Fetcher::Score::NCB.find(date) }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NCB).to receive(:get).with('basketball', 'mens-college-basketball', dates: 20151113, limit: 200).and_return(json_stub) }
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.pregame? } }
        it { expect(event.status.detail).to eq("TBD") }
        it { expect(event.date.to_date).to eq(Date.new(2015, 11, 13)) }
        it { expect(event.competitors.first.name).to eq('Tigers') }
        it { expect(event.competitors.first.location).to eq('Auburn') }
        it { expect(event.competitors.first.conference_id).to eq('23') }
        it { expect(event.competitors.first.is_active).to eq(true) }
      end
    end
  end
end


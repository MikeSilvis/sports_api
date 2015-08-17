require 'spec_helper'

describe SportsApi::Fetcher::Score::NFL do
  describe '#find' do
    let(:find) { SportsApi::Fetcher::Score::NFL.find(1, week) }

    describe 'pregame' do
      let(:week) { 1 }
      let(:json_stub) { StubbedJson.get('pregame.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NFL).to receive(:get).with('football', 'nfl', week: week, seasontype: 1).and_return(json_stub) }
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
      let(:json_stub) { StubbedJson.get('inprogress.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NFL).to receive(:get).with('football', 'nfl', week: week, seasontype: 1).and_return(json_stub) }
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.inprogress? } }
        it { expect(event.date).to eq(Date.new(2015, 8, 10)) }
        it { expect(event.competitors.first.name).to eq('Minnesota Vikings') }
        it { expect(event.competitors.first.record.summary).to eq('0-0') }
        it { expect(event.score).to eq('7 - 3') }
      end
    end

    describe 'postgame' do
      let(:week) { 1 }
      let(:json_stub) { StubbedJson.get('postgame.json') }
      let(:find) { SportsApi::Fetcher::Score::NFL.find(1, week) }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NFL).to receive(:get).with('football', 'nfl', week: week, seasontype: 1).and_return(json_stub) }
      context 'event info' do
        let(:event) { find.events.detect { |event| event.status.final? } }
        let(:thumbnail_url) { 'http://a.espncdn.com/media/motion/2015/0816/dm_150816_nfl_eagles_colts_highlight/dm_150816_nfl_eagles_colts_highlight.jpg' }
        it { expect(event.date).to eq(Date.new(2015, 8, 16)) }
        it { expect(event.headline.photo).to eq(thumbnail_url) }
      end
    end

  end
end

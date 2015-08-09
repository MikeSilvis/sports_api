require 'spec_helper'

describe SportsApi::Fetcher::Score::NBA < SportsApi::Fetcher::Score do
  it { expect(SportsApi::Fetcher::Score::NBA.new(Date.today)).to_not eq(nil) }
  describe '#find' do
    context 'past game' do
      let(:date) { Date.new(2015, 4, 19) }
      let(:find) { SportsApi::Fetcher::Score::NBA.find(date) }
      let(:json_stub) { StubbedJson.get('past.json') }
      before { expect_any_instance_of(SportsApi::Fetcher::Score::NBA).to receive(:get).with('basketball', 'nba', date).and_return(json_stub) }
      it { expect(find.calendar.dates.size).to eq(227) }
      it { expect(find.name).to eq('National Basketball Association') }
    end
  end
end


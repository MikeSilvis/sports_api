require 'spec_helper'

describe SportsApi::Fetcher::Score do
  describe 'new' do
    it { expect(SportsApi::Fetcher::Score.new).to_not eq(nil) }
  end
end

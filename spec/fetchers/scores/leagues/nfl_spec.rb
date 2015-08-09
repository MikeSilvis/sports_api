require 'spec_helper'

describe SportsApi::Fetcher::Score::NFL < SportsApi::Fetcher::Score do
  it { expect(SportsApi::Fetcher::Score::NFL.new).to_not eq(nil) }
end


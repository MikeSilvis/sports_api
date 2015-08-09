require 'spec_helper'

describe SportsApi do
  it 'has a version number' do
    expect(SportsApi::VERSION).not_to be nil
  end

  context 'defines specific leagues' do
    it { expect(SportsApi::NFL).to eq('nfl') }
  end
end

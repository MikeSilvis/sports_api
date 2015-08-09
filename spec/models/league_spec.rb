require 'spec_helper'

describe SportsApi::Model::League do
  describe 'new' do
    it { expect(SportsApi::Model::League.new).to_not eq(nil) }
    it { expect(SportsApi::Model::League::DAY).to eq('day') }
  end
end

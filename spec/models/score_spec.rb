require 'spec_helper'

describe SportsApi::Model::Score do
  describe 'new' do
    it { expect(SportsApi::Model::Score.new).to_not eq(nil) }
  end
end

require 'spec_helper'

describe SportsApi::Model::Team do
  describe 'new' do
    it { expect(SportsApi::Model::Team.new).to_not eq(nil) }
  end
end

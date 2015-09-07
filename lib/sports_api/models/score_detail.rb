require 'active_support/inflector'

class SportsApi::Model::ScoreDetail
  attr_accessor :headline,
                :contents

  def headline=(headline)
    @headline = headline.titleize
  end
end

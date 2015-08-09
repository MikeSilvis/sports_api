class SportsApi::Model::Schedule::Day
  attr_accessor :dates

  def initialize(dates)
    self.dates = dates
  end
end

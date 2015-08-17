class SportsApi::Model::Schedule::List
  attr_accessor :label,
                :detail,
                :week,
                :season,
                :start_date,
                :end_date,
                :category

  def week=(week)
    @week = week.to_i
  end

  def season=(season)
    @season = season.to_i
  end
end

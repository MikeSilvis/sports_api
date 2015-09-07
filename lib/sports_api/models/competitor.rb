class SportsApi::Model::Competitor
  attr_accessor :type,
                :home_away,
                :score,
                :winner,
                :data_name,
                :name,
                :location,
                :abbreviation,
                :record,
                :id,
                :linescores,
                :rank

  def rank=(rank)
    @rank = rank == 99 ? nil : rank
  end
end

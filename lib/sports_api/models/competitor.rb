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
                :rank,
                :conference_id,
                :division_one

  def rank=(rank)
    @rank = rank == 99 ? nil : rank.to_s
  end
end

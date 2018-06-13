class Cup < ActiveRecord::Base
  def matches
    Match.where("cup_id = ?", self)
  end

  def total_matches_count
    matches.count
  end

  def played_matches
    matches.where(status: true)
  end

  def played_matches_count
    played_matches.count
  end

  def on_going
    start_date <= Date.today && end_date >= Date.today
  end

  def teams
    Team.where("cup_id = ?", self)
  end
end

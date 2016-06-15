class Team < ActiveRecord::Base
  def matches
    Match.where("team1_id = ? OR team2_id = ?", self, self)
  end

  def goals
    matches.inject(0) {|sum, match| sum + (match.closed? ? (match.team1 == self ? match.mainscore1 : match.mainscore2) : 0)}
  end

  def goal_difference
    goals*2 - matches.inject(0) {|sum, match| sum + (match.closed? ? match.mainscore1 + match.mainscore2 : 0)}
  end

  def total_matches_count
    matches.count
  end

  def played_matches_count
    matches.where(status: true).count
  end

  def remain_matches_count
    total_matches_count - played_matches_count
  end

  def update_score
    score = 0
    matches.each do |match|
      score += match.equal? ? 1 : (match.winner == self ? 3 : 0)
    end
    update_attributes(score: score)
  end
end

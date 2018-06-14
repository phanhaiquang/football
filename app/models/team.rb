class Team < ActiveRecord::Base
  belongs_to :cup

  def matches
    Match.where(cup: cup).where("team1_id = ? OR team2_id = ?", self, self)
  end

  def total_matches_count
    matches.count
  end

  def played_matches
    matches.where(status: true)
  end

  def won_matches
    played_matches.select{|match| match.winner == self}
  end

  def drew_matches
    played_matches.select{|match| match.mainscore1 == match.mainscore2}
  end

  def loss_matches
    played_matches.select{|match| match.looser == self}
  end

  def goal_for
    played_matches.inject(0) {|sum, match| sum + (match.team1 == self ? match.mainscore1 : match.mainscore2)}
  end

  def goal_against
    played_matches.inject(0) {|sum, match| sum + (match.team1 == self ? match.mainscore2 : match.mainscore1)}
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

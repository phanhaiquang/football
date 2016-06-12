class Team < ActiveRecord::Base
  def matches
    Match.where("team1_id = ? OR team2_id = ?", self, self)
  end

  def update_score
    score = 0
    matches.each do |match|
      score += match.equal? ? 1 : (match.winner == self ? 3 : 0)
    end
    update_attributes(score: score)
  end
end

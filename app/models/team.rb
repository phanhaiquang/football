class Team < ActiveRecord::Base

  def update_score
    score = 0
    Match.all.each do |match|
      score += match.equal? ? 1 : (match.winner == self ? 3 : 0)
    end
    update_attributes(score: score)
  end
end

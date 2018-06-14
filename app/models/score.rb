class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :cup

  def update_score
    score = 0
    user.predictions.each do |prediction|
      next if prediction.cup_id != cup_id
      score += prediction.win? ? 2 : (prediction.subwin? ? 1 : 0)
    end
    update_attributes(score: score)
  end
end

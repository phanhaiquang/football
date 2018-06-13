class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :cup


  def user
    User.find(user_id)
  end

  def update_score
    score = 0
    self.user.predictions.each do |prediction|
      score += (prediction.cup_id != cup_id)? 0 : prediction.win?    ? 2 :
               prediction.subwin? ? 1 : 0
    end
    update_attributes(score: score)
  end
end

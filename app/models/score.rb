class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :cup

  def update_score_reward
    score = 0
    user.predictions.each do |prediction|
      next if prediction.cup_id != cup_id || prediction.match.knockout?
      score += prediction.win? ? 2 : (prediction.subwin? ? 1 : 0)
    end
    update_attributes(score: score)
    reward = 0
    knockout_reward = 0
    user.predictions.each do |prediction|
      next if prediction.cup_id != cup_id
      if prediction.match.knockout?
        knockout_reward += prediction.reward.nil? ? 0 : prediction.reward
      else
        reward += prediction.reward.nil? ? 0 : prediction.reward
      end
    end
    update_attributes(reward: reward)
    update_attributes(knockout_reward: knockout_reward)
  end
end

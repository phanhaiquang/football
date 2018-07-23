class AddKnockoutRewardToScores < ActiveRecord::Migration
  def change
    add_column :scores, :knockout_reward, :integer
  end
end

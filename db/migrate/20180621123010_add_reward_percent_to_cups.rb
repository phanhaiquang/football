class AddRewardPercentToCups < ActiveRecord::Migration
  def change
    add_column :cups, :reward_percent, :float
    Cup.find(1).update_attributes(reward_percent: 0.4)
    Cup.find(2).update_attributes(reward_percent: 0.5)
  end
end

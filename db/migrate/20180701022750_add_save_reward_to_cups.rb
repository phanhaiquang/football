class AddSaveRewardToCups < ActiveRecord::Migration
  def change
    add_column :cups, :save_reward, :integer
    Cup.find(1).update_attributes(save_reward: 0)
    Cup.find(2).update_attributes(save_reward: 0)
  end
end

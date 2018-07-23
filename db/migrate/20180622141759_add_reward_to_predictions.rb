class AddRewardToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :reward, :integer
  end
end

class AddRewardToScores < ActiveRecord::Migration
  def change
    add_column :scores, :reward, :integer
  end
end

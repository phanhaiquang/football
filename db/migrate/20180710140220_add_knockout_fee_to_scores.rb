class AddKnockoutFeeToScores < ActiveRecord::Migration
  def change
    add_column :scores, :knockout_fee, :integer
  end
end

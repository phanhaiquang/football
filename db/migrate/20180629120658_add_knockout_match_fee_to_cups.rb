class AddKnockoutMatchFeeToCups < ActiveRecord::Migration
  def change
    add_column :cups, :knockout_match_fee, :integer
    Cup.find(1).update_attributes(knockout_match_fee: 0)
    Cup.find(2).update_attributes(knockout_match_fee: 20000)
  end
end

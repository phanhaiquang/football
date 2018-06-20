class AddMatchFeeToCups < ActiveRecord::Migration
  def change
    add_column :cups, :match_fee, :integer
    Cup.find(1).update_attributes(match_fee: 10000)
    Cup.find(2).update_attributes(match_fee: 5000)
  end
end

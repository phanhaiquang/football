class RemoveMatchFeeFromCups < ActiveRecord::Migration
  def change
    remove_column :cups, :match_fee
    remove_column :cups, :knockout_match_fee
  end
end

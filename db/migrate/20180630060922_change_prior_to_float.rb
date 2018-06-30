class ChangePriorToFloat < ActiveRecord::Migration
  def change
    change_column :matches, :prior1, :float
    change_column :matches, :prior2, :float
  end
end

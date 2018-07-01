class AddPenScoreToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :penscore1, :integer
    add_column :matches, :penscore2, :integer
  end
end

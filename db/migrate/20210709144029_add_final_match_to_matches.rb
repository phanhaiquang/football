class AddFinalMatchToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :special_final, :boolean
  end
end

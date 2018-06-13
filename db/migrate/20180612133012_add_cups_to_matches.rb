class AddCupsToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :cup, index: true, foreign_key: true, default: 1
  end
end

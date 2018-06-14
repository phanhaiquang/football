class AddCupsToPredictions < ActiveRecord::Migration
  def change
    add_reference :predictions, :cup, index: true, foreign_key: true
  end
end

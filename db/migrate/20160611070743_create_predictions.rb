class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.references :match, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :mainscore1
      t.integer :mainscore2

      t.timestamps null: false
    end
  end
end

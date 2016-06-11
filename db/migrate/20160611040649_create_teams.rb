class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :score
      t.string :coach

      t.timestamps null: false
    end
  end
end

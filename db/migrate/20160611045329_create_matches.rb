class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :team1, references: :teams
      t.references :team2, references: :teams
      t.integer :mainscore1
      t.integer :mainscore2
      t.integer :subscore1
      t.integer :subscore2

      t.timestamps null: false
    end
  end
end

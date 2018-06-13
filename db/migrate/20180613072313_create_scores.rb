class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user, index: true, foreign_key: true
      t.references :cup, index: true, foreign_key: true
      t.integer :score

      t.timestamps null: false
    end
    User.all.each do |u|
      Cup.all.each do |c|
        Score.create :user => u, :cup => c, :score => 0
      end
    end
    Score.where("cup_id = ?", Cup.first.id).each do |s|
      s.update_attributes(score: User.find(s.user_id).score)
    end
  end
end

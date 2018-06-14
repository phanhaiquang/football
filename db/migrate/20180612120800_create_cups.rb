class CreateCups < ActiveRecord::Migration
  def change
    create_table :cups do |t|
      t.string :name
      t.string :host
      t.string :logo
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
    Cup.create :name => "Euro 2016",      :host => "France", :logo => "euro2016.jpg",     :start_date => "2016-06-10", :end_date => "2016-07-10"
    Cup.create :name => "World Cup 2018", :host => "Russia", :logo => "worldcup2018.jpg", :start_date => "2018-06-14", :end_date => "2018-07-15"
  end
end

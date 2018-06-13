class InsertTeamsForWc < ActiveRecord::Migration
  def change 
    Team.create :name => "Russia",          :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Saudi Arabia",    :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Egypt",           :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Uruguay",         :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Portugal",        :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Spain",           :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Morocco",         :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Iran",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "France",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Australia",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Peru",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Denmark",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Argentina",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Iceland",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Croatia",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Nigeria",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Brazil",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Switzerland",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Costa Rica",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Serbia",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Germany",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Mexico",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Sweden",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "South Korea",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Belgium",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Panama",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Tunisia",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "England",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Poland",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Senegal",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Colombia",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
    Team.create :name => "Japan",            :score => nil, :coach => nil, :status => true,  :cup_id => 2
  end
end

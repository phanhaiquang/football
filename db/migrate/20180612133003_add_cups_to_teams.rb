class AddCupsToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :cup, index: true, foreign_key: true, default: 1
  end
end

class AddStatusToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :status, :boolean, default: true
  end
end

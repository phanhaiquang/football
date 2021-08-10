class AddLogoUrlToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :logourl, :string, default: ''
  end
end

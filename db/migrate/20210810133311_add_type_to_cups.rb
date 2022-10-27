class AddTypeToCups < ActiveRecord::Migration
  def change
    add_column :cups, :is_league, :boolean, default: false
  end
end

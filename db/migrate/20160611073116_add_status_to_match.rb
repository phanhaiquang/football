class AddStatusToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :status, :boolean, default: false
    add_column :matches, :time, :datetime
  end
end

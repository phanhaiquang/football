class AddResultIdToCups < ActiveRecord::Migration
  def change
    add_column :cups, :result_id, :integer
    Cup.find(1).update_attributes(result_id: 424)
    Cup.find(2).update_attributes(result_id: 467)
  end
end

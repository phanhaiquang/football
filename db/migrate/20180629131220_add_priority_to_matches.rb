class AddPriorityToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :prior1, :integer
    add_column :matches, :prior2, :integer
  end
end

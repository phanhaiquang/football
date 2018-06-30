class AddKnockoutToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :knockout, :boolean
    Match.all.each do |m|
      m.update_attributes(knockout: false)
    end
  end
end

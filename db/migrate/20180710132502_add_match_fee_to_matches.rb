class AddMatchFeeToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :fee, :integer
    Match.all.each do |m|
      if m.knockout?
        m.update_attributes(fee: m.cup.knockout_match_fee)
      else
        m.update_attributes(fee: m.cup.match_fee)
      end
    end
  end
end

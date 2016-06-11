class Match < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"

  after_save :update_scores

  def winner
    mainscore1 > mainscore2 ? team1 :
      mainscore1 < mainscore2 ? team2 : nil
  end

  def equal?
    mainscore1 == mainscore2 
  end

  def update_scores
    team1.update_score
    team2.update_score
  end
end

class Match < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  has_many :predictions

  after_save :update_score, if: -> { closed? }

  def winner
    mainscore1 > mainscore2 ? team1 :
      mainscore1 < mainscore2 ? team2 : nil
  end

  def equal?
    mainscore1 == mainscore2 
  end

  def started?
    Time.now >= time
  end

  def closed?
    status == true
  end

  def update_score
    update_teams_score
    update_users_score
  end

  def update_teams_score
    team1.update_score
    team2.update_score
  end

  def update_users_score
    predictions.user.update_score
  end
end

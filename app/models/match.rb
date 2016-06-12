class Match < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  has_many :predictions

  default_scope { order(:time) }

  after_save :update_score, if: -> { closed? }

  def name
    team1.name + ' vs ' + team2.name + " (#{time.to_s(:match)})"
  end

  def mainscores
    "#{mainscore1} - #{mainscore2}"
  end

  def subscores
    "#{subscore1} - #{subscore2}"
  end

  def winner
    if closed?
      mainscore1 > mainscore2 ? team1 :
      mainscore1 < mainscore2 ? team2 : nil
    end
  end

  def prediction_winners
    User.where(id: Prediction.where(match: self, mainscore1: mainscore1, mainscore2: mainscore2).map(&:user_id))
  end

  def equal?
    closed? && (mainscore1 == mainscore2) 
  end

  def started?
    Time.now >= time - 15.minutes
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
    User.all.each do |user|
      user.update_score
    end
  end
end

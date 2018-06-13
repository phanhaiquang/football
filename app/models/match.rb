class Match < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  has_many :predictions

  default_scope { order(:time) }

  after_save :update_score, if: -> { closed? }

  def prediction_of(user)
    predictions.find_by(user: user)
  end

  def name
    team1.name + ' vs ' + team2.name + " (#{time.to_s(:match)})"
  end

  def short_name
    team1.name + ' vs ' + team2.name
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

  def looser
    if closed?
      mainscore1 > mainscore2 ? team2 :
      mainscore1 < mainscore2 ? team1 : nil
    end
  end

  def prediction_winners
    User.where(id: Prediction.where(match: self, mainscore1: mainscore1, mainscore2: mainscore2).map(&:user_id))
  end

  def equal?
    closed? && (mainscore1 == mainscore2) 
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
    Score.all.each do |score|
      score.update_score
    end
  end

  def cup
    Cup.find(cup_id)
  end
end

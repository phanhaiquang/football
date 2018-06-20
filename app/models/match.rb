class Match < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: "team1_id"
  belongs_to :team2, class_name: "Team", foreign_key: "team2_id"
  has_many :predictions
  belongs_to :cup

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

  def prediction_winners_names
    prediction_winners.map(&:name).join(", ")
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

  def human_status
    closed? ? 'Finished' : started? ? 'Started' : ''
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

  def update_result
    uri = URI.parse("http://api.football-data.org/v1/competitions/"+cup.result_id.to_s+"/fixtures")
    http = Net::HTTP.new(uri.host, uri.port)
    resp = http.get(uri.request_uri)
    data = JSON.parse(resp.body)
    match_results = data['fixtures'].select{|m| (m['homeTeamName'] == team1.name && m['awayTeamName'] == team2.name)}
    if match_results.count > 0
      if match_results.last['status'] == 'IN_PLAY'
        update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], status: false)
      end
      if match_results.last['status'] == 'FINISHED'
        update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], status: true)
      end
    end
  end
end

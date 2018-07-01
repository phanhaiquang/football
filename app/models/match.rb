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

  def fullscores
    if !subscore1.nil? && !subscore2.nil?
      if !penscore1.nil? && !penscore2.nil?
        "#{mainscore1+subscore1} - #{mainscore2+subscore2}" + " (#{penscore1} - #{penscore2})"
      else
        "#{mainscore1+subscore1} - #{mainscore2+subscore2}"
      end
    else
      mainscores
    end
  end

  def priorities
    if !prior1.nil? && prior1 > 0
      "#{team1.name} #{prior1}"
    else 
      if !prior2.nil? &&prior2 > 0 
        "#{team2.name} #{prior2}"
      else
        "-"
      end
    end
  end

  def winner
    if closed?
      if !subscore1.nil? && !subscore2.nil? && !penscore1.nil? && !penscore2.nil?
        subscore1 > subscore2 ? team1 :
        subscore1 < subscore2 ? team2 :
        penscore1 > penscore2 ? team1 :
        penscore1 < penscore2 ? team2 : nil
      else
        if !subscore1.nil? && !subscore2.nil?
          subscore1 > subscore2 ? team1 :
          subscore1 < subscore2 ? team2 : nil
        else
          mainscore1 > mainscore2 ? team1 :
          mainscore1 < mainscore2 ? team2 : nil
        end
      end
    end
  end

  def looser
    if closed?
      if !subscore1.nil? && !subscore2.nil? && !penscore1.nil? && !penscore2.nil?
        subscore1 > subscore2 ? team2 :
        subscore1 < subscore2 ? team1 :
        penscore1 > penscore2 ? team2 :
        penscore1 < penscore2 ? team1 : nil
      else
        if !subscore1.nil? && !subscore2.nil?
          subscore1 > subscore2 ? team2 :
          subscore1 < subscore2 ? team1 : nil
        else
          mainscore1 > mainscore2 ? team2 :
          mainscore1 < mainscore2 ? team1 : nil
        end
      end
    end
  end

  def prediction_winners
    if knockout?
      User.where(id: predictions.select{|p| p.win?}.map(&:user_id))
    else
      User.where(id: Prediction.where(match: self, mainscore1: mainscore1, mainscore2: mainscore2).map(&:user_id))
    end
  end

  def prediction_winners_count
    prediction_winners.count
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
    update_predictions_reward
    update_users_score_reward
  end

  def update_teams_score
    if !knockout?
      team1.update_score
      team2.update_score
      if team1.played_matches.count == 3
        team1.update_status
      end
      if team2.played_matches.count == 3
        team2.update_status
      end
    else
      winner.update_attributes(status: true)
      looser.update_attributes(status: false)
    end
  end

  def update_predictions_reward
    if knockout?
      if prediction_winners_count == 0
        cup.update_attributes(save_reward: cup.knockout_match_fee*predictions.count)
      else
        predictions.all.each do |prediction|
          next if !prediction.win?
          prediction.update_attributes(reward: ((cup.knockout_match_fee*predictions.count+cup.save_reward)/prediction_winners_count).round)
        end
        cup.update_attributes(save_reward: 0)
      end
    else
      predictions.all.each do |prediction|
        next if !prediction.win?
        prediction.update_attributes(reward: (cup.reward_percent*cup.match_fee*valid_users_count/prediction_winners_count).round)
      end
    end
  end

  def update_users_score_reward
    Score.all.each do |score|
      score.update_score_reward
    end
  end

  def update_result
    if team1.name == "South Korea"
      home_team_name = "Korea Republic"
    else
      home_team_name = team1.name
    end
    if team2.name == "South Korea"
      away_team_name = "Korea Republic"
    else
      away_team_name = team2.name
    end
    uri = URI.parse("http://api.football-data.org/v1/competitions/"+cup.result_id.to_s+"/fixtures")
    http = Net::HTTP.new(uri.host, uri.port)
    resp = http.get(uri.request_uri)
    if resp.kind_of? Net::HTTPSuccess
      data = JSON.parse(resp.body)
      match_results = data['fixtures'].select{|m| (m['homeTeamName'] == home_team_name && m['awayTeamName'] == away_team_name)}
      if match_results.count > 0
        if match_results.last['status'] == 'IN_PLAY'
          if match_results.last['result'].key?('extraTime')
            if match_results.last['result'].key?('penaltyShootout')
              update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], subscore1: match_results.last['result']['extraTime']['goalsHomeTeam'], subscore2: match_results.last['result']['extraTime']['goalsAwayTeam'], penscore1: match_results.last['result']['penaltyShootout']['goalsHomeTeam'], penscore2: match_results.last['result']['penaltyShootout']['goalsAwayTeam'], status: false)
            else
              update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], subscore1: match_results.last['result']['extraTime']['goalsHomeTeam'], subscore2: match_results.last['result']['extraTime']['goalsAwayTeam'], status: false)
            end
          else
            update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], status: false)
          end
        end
        if match_results.last['status'] == 'FINISHED'
          if match_results.last['result'].key?('extraTime')
            if match_results.last['result'].key?('penaltyShootout')
              update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], subscore1: match_results.last['result']['extraTime']['goalsHomeTeam'], subscore2: match_results.last['result']['extraTime']['goalsAwayTeam'], penscore1: match_results.last['result']['penaltyShootout']['goalsHomeTeam'], penscore2: match_results.last['result']['penaltyShootout']['goalsAwayTeam'], status: true)
            else
              update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], subscore1: match_results.last['result']['extraTime']['goalsHomeTeam'], subscore2: match_results.last['result']['extraTime']['goalsAwayTeam'], status: true)
            end
          else
            update_attributes(mainscore1: match_results.last['result']['goalsHomeTeam'], mainscore2: match_results.last['result']['goalsAwayTeam'], status: true)
          end
        end
      end
    end
  end

  def valid_users
    cup.active_users.select{|u| u.predictions_of_cup(cup).first.match.id <= id}
  end

  def valid_users_count
    valid_users.count
  end
end

class Team < ActiveRecord::Base
  belongs_to :cup
  before_save :set_logourl

  def matches
    Match.where(cup: cup).where("team1_id = ? OR team2_id = ?", self, self)
  end

  def total_matches_count
    matches.count
  end

  def played_matches
    matches.where(status: true, knockout: false)
  end

  def won_matches
    played_matches.select{|match| match.winner == self}
  end

  def drew_matches
    played_matches.select{|match| match.mainscore1 == match.mainscore2}
  end

  def loss_matches
    played_matches.select{|match| match.looser == self}
  end

  def goal_for
    played_matches.inject(0) {|sum, match| sum + (match.team1 == self ? match.mainscore1 : match.mainscore2)}
  end

  def goal_against
    played_matches.inject(0) {|sum, match| sum + (match.team1 == self ? match.mainscore2 : match.mainscore1)}
  end

  def remain_matches_count
    total_matches_count - played_matches_count
  end

  def update_score
    score = 0
    played_matches.each do |match|
      score += match.equal? ? 1 : (match.winner == self ? 3 : 0)
    end
    update_attributes(score: score)
  end

  def update_status
    group = Team.where(cup: cup, cup_group: cup_group).sort_by{ |t| [-t.score, t.goal_against-t.goal_for, -t.goal_for] }
    next_stage_teams = group.first(2)
    eliminated_teams = group.last(2)
    next_stage_teams.each do |t|
      t.update_attributes(status: true)
    end
    eliminated_teams.each do |t|
      t.update_attributes(status: false)
    end
  end

  private
    def set_logourl
      self.logourl = get_logourl
      true
    end

    def get_logourl
      require 'net/http'
      uri = URI.parse("http://api.football-data.org/v2/competitions/"+cup.result_id.to_s+"/teams")
      http = Net::HTTP.new(uri.host, uri.port).start
      request = Net::HTTP::Get.new(uri.request_uri, {"X-Auth-Token"=>ENV['PG_API_KEY']})
      resp = http.request(request)
      if resp.kind_of? Net::HTTPSuccess
        data = JSON.parse(resp.body)
        teams = data['teams'].select{|m| (m['name'] == name)}
        if teams.count > 0
          teams.last['crestUrl']
        else
          ''
        end
      else
        ''
      end
    end
end

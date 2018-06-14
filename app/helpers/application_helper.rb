module ApplicationHelper
  def matches_started
    APP_CONFIG["skip_validation"] ? [] : Match.all.select(&:started?).map(&:id)
  end

  def predicable_matches(user)
    if params[:action] == "edit"
      Match.where(id: Prediction.find_by_id(params[:prediction_id]).match)
    else
      all_match_ids = Match.where(cup_id: params[:cup_id]).ids
      user_match_ids = Prediction.where(user: user).map{|p| p.match.id}
      Match.where(id: all_match_ids - user_match_ids - matches_started)
    end
  end
end

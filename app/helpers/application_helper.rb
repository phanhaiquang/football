module ApplicationHelper
  def matches_started
    APP_CONFIG["skip_validation"] ? [] : Match.all.select(&:started?).map(&:id)
  end

  def predicable_matches(user)
    if params[:action] == "edit"
      Match.where(id: Prediction.find_by_id(params[:prediction_id]).match)
    else
      Match.where(id: Match.where(cup_id: params[:cup_id]).ids - Prediction.where(user: user).map{|p| p.match.id} - matches_started)
    end
  end
end

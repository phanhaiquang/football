module ApplicationHelper
  def matches_started
    ENV["SKIP_VALIDATION"] ? [] : Match.all.select(&:started?).map(&:id)
  end

  def predicable_matches(user)
    if params[:action] == "edit"
      Match.where(id: Prediction.find_by_id(params[:id]).match)
    else
      Match.where(id: Match.all.ids - Prediction.where(user: user).map{|p| p.match.id} - matches_started)
    end
  end
end

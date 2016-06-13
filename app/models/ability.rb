class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.admin?
      can :manage, :all
    else
      can [:create, :read], Prediction
      can [:update, :destroy], Prediction, Prediction.all do |prediction|
        (prediction.user_id == user.id) && prediction.open?
      end
      can :read, :all
    end
  end
end

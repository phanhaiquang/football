class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.admin?
      can :manage, :all
    else
      can :crud, Prediction
      can :read, :all
    end
  end
end

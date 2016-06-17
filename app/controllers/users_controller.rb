class UsersController < ApplicationController
  def index
    @users = User.where(admin: false).select{|user| user.predictions.count > 0}.order(score: :desc)
  end
end

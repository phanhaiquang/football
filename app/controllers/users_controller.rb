class UsersController < ApplicationController
  def index
    @users = User.where(admin: false).order(score: :desc)
  end
end

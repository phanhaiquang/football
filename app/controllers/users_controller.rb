class UsersController < ApplicationController
  def index
    @users = User.all.order(score: :desc)
  end
end

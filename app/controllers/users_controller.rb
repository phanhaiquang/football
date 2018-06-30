class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    admin_ids = Score.where(user_id: User.where(admin: true).ids).ids
    inactive_ids = Score.where(user_id: User.select{|u| u.inactive?(params[:cup_id])}.map{|u| u.id}).ids
    ids = Score.where(cup_id: params[:cup_id]).ids - admin_ids - inactive_ids
    @userscores = Score.where(id: ids).order('score desc')
    @userknockoutrewards = Score.where(id: ids).order('knockout_reward desc')
    @cup = Cup.find(params[:cup_id])
    @groupmatches = @cup.matches.where(knockout: false)
    @knockoutmatches = @cup.matches.where(knockout: true)
    @stage = params[:stage]
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      # bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end
end

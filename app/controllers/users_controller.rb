class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @cup = Cup.find(params[:cup_id])
    @stage = params[:stage]
    admin_ids = Score.where(user_id: User.where(admin: true).ids).ids
    inactive_ids = Score.where(user_id: User.select{|u| u.inactive?(@cup)}.map{|u| u.id}).ids + Score.where(user_id: User.select{|u| u.predictions_of_stage(@cup, true).count == 0}.map{|u| u.id}).ids
    ids = Score.where(cup_id: @cup.id).ids - admin_ids - inactive_ids
    if @stage == 'group'
      @userscores = Score.where(id: ids).order('score desc nulls last')
      @groupmatches = @cup.matches.where(knockout: false)
    end
    if @stage == 'knockout'
      @userknockoutrewards = Score.where(id: ids).sort_by{ |u| [-u.knockout_profit] }
      @knockoutmatches = @cup.matches.where(knockout: true)
    end
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

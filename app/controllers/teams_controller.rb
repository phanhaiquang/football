class TeamsController < ApplicationController
  load_and_authorize_resource param_method: :team_params
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_cup, only: [:index, :create, :new]

  def index
    @teams = @cup.teams.sort_by{ |t| [t.cup_group, -t.score, t.goal_against-t.goal_for, -t.goal_for] }
  end

  def show
    @cup = @team.cup
  end

  def new
    @team = Team.new
    @team.cup_id = @cup.id
  end

  def edit; end

  def create
    @team = Team.new(team_params.merge(cup_id: @cup.id))

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path(cup_id: @team.cup_id),
      notice: 'Team was successfully destroyed.'
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_cup
      @cup = Cup.find(params[:cup_id])
    end

    def team_params
      params.require(:team).permit(:name, :score, :coach, :status)
    end
end

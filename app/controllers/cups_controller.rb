class CupsController < ApplicationController
  load_and_authorize_resource cup_method: :cup_params
  before_action :set_cup, only: [:show, :edit, :update, :destroy]

  def index
    @cups = Cup.all
  end

  def show
    @nextmatches = @cup.matches.where("time >= ?", Time.now).order(time: :asc).first(5)
    @prematches = @cup.matches.where("time <= ?", Time.now).reorder(time: :desc).first(5)
  end

  def new
    @cup = Cup.new
  end

  def edit
  end

  def create
    @cup = Cup.new(cup_params)

    if @cup.save
      redirect_to @cup, notice: 'Cup was successfully created.'
    else
      render :new
    end
  end

  def update
    if @cup.update(cup_params)
      redirect_to @cup, notice: 'Cup was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cup.destroy
    redirect_to cups_url, notice: 'Cup was successfully destroyed.'
  end

  private
    def set_cup
      @cup = Cup.find(params[:cup_id])
    end

    def cup_params
      params.require(:cup).permit(:name, :host, :logo, :start_date, :end_date)
    end
end

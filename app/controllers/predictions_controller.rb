class PredictionsController < ApplicationController
  load_and_authorize_resource param_method: :prediction_params
  before_action :set_prediction, only: [:show, :edit, :update, :destroy]
  before_action :set_cup, only: [:index, :create, :new]

  def index
    @predictions = current_user.predictions.where(cup_id: @cup.id).order(:match_id)
  end

  def show; end

  def new
    @prediction = Prediction.new(
      user_id: current_user.id,
      cup_id: @cup.id
    )
  end

  def edit; end

  def create
    @prediction = Prediction.new(prediction_params.merge(
      user_id: current_user.id,
      cup_id: @cup.id
    ))

    if @prediction.save
      redirect_to @prediction, notice: 'Prediction was successfully created.'
    else
      render :new
    end
  end

  def update
    if @prediction.update(prediction_params)
      redirect_to @prediction, notice: 'Prediction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @prediction.destroy
    redirect_to predictions_path(cup_id: @prediction.cup_id), 
      notice: 'Prediction was successfully destroyed.'
  end

  private
    def set_prediction
      @prediction = Prediction.find(params[:prediction_id])
    end

    def set_cup
      @cup = Cup.find(params[:cup_id])
    end

    def prediction_params
      params.require(:prediction).permit(:match_id, :mainscore1, :mainscore2)
    end
end

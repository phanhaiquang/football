class CupsController < ApplicationController
  load_and_authorize_resource cup_method: :cup_params
  before_action :set_cup, only: [:show, :edit, :update, :destroy]

  # GET /cups
  # GET /cups.json
  def index
    @cups = Cup.all
  end

  # GET /cups/1
  # GET /cups/1.json
  def show
    @nextmatches = @cup.matches.where("time >= ?", Time.now).order(:time)
    if @nextmatches.count > 0
      @nextmatch = @nextmatches.first
    end
    @prematches = @cup.matches.where("time <= ?", Time.now).order(:time)
    if @prematches.count > 0
      @prematch = @prematches.last
    end
  end

  # GET /cups/new
  def new
    @cup = Cup.new
  end

  # GET /cups/1/edit
  def edit
  end

  # POST /cups
  # POST /cups.json
  def create
    @cup = Cup.new(cup_params)

    respond_to do |format|
      if @cup.save
        format.html { redirect_to @cup, notice: 'Cup was successfully created.' }
        format.json { render :show, status: :created, location: @cup }
      else
        format.html { render :new }
        format.json { render json: @cup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cups/1
  # PATCH/PUT /cups/1.json
  def update
    respond_to do |format|
      if @cup.update(cup_params)
        format.html { redirect_to @cup, notice: 'Cup was successfully updated.' }
        format.json { render :show, status: :ok, location: @cup }
      else
        format.html { render :edit }
        format.json { render json: @cup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cups/1
  # DELETE /cups/1.json
  def destroy
    @cup.destroy
    respond_to do |format|
      format.html { redirect_to cups_url, notice: 'Cup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cup
      @cup = Cup.find(params[:cup_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cup_params
      params.require(:cup).permit(:name, :host, :logo, :start_date, :end_date)
    end
end

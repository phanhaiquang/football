class MatchesController < ApplicationController
  load_and_authorize_resource param_method: :match_params
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :set_cup, only: [:index, :create, :new]

  # GET /matches
  # GET /matches.json
  def index
    @matches = @cup.matches.order(:time)
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
    @match.cup_id = @cup.id
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    @match.cup_id = @cup.id

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_path(:cup_id => @match.cup_id), notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:match_id])
    end

    def set_cup
      @cup = Cup.find(params[:cup_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:team1_id, :team2_id, :time, :status, :mainscore1, :mainscore2, :subscore1, :subscore2)
    end
end

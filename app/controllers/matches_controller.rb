kclass MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

      respond_to do |format|
              if @match.save
              elo_change
              format.html { redirect_to @match, notice: 'Match was successfully created.' }
              format.json { render :show, status: :created, location: @match }
              else
              format.html { render :new }
              format.json { render json: @match.errors, status: :unprocessable_entity }
              end 
      end
  end

  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:player_red_id, :player_blue_id, :player_red_score, :player_blue_score)
    end

    def elo_change
        if @match.player_red_score == 10
          winner = @match.player_red
          loser = @match.player_blue
          loser_score = @match.player_blue_score
        else
          winner = @match.player_blue
          loser = @match.player_red
          loser_score = @match.player_red_score
        end
        elo_difference = (1.3*loser.elo/winner.elo)*(20-loser_score)
        winner.elo = winner.elo + elo_difference
        loser.elo = loser.elo - elo_difference*0.75
        winner.save
        loser.save
    end
end

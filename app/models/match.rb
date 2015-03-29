class Match < ActiveRecord::Base
  belongs_to :player_red, :class_name => 'Player'
  belongs_to :player_blue, :class_name => 'Player'
  scope :players_matches, ->(id)  { where('player_red_id=? OR player_blue_id=?', id, id) }

  WIN_SCORE = 10
  validates :player_red_score, :numericality => { :only_integer => true, :less_than => (WIN_SCORE+1), :greater_or_equal_to => 0}
  validates :player_blue_score, :numericality => { :only_integer => true, :less_than => (WIN_SCORE+1), :greater_or_equal_to => 0} 
  validate :scores_are_correct?

  after_save :elo_change



  def scores_are_correct?
         if player_red == player_blue
        errors.add(:player_red)
        errors.add(:player_blue)
		end
		if (player_red_score == player_blue_score) || ((player_red_score != WIN_SCORE) && (player_blue_score != WIN_SCORE)) 
			errors.add(:player_red_score)
			errors.add(:player_blue_score)
		end
  end

      def elo_change
        if player_red_score == 10
          winner = player_red
          loser = player_blue
          loser_score = player_blue_score
        else
          winner = player_blue
          loser = player_red
          loser_score = player_red_score
        end
        elo_difference = (1.2*loser.elo/winner.elo)*(20-loser_score)
        winner.elo = winner.elo + elo_difference
        loser.elo = loser.elo - elo_difference*0.75
        winner.save
        loser.save
    end

  def win?(id)
  	(player_red_id == id && player_red_score == WIN_SCORE) || (player_blue_id == id && player_blue_score == WIN_SCORE)
  end
end

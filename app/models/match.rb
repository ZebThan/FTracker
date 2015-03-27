class Match < ActiveRecord::Base
  belongs_to :player_red, :class_name => 'Player'
  belongs_to :player_blue, :class_name => 'Player'
  scope :players_matches, ->(id)  { where('player_red_id=? OR player_blue_id=?', id, id) }


  validates :player_red_score, :numericality => { :only_integer => true, :less_than => 11, :greater_or_equal_to => 0}
  validates :player_blue_score, :numericality => { :only_integer => true, :less_than => 11, :greater_or_equal_to => 0} 
  validate :scores_are_correct?

  def scores_are_correct?
         if player_red == player_blue
        errors.add(:player_red)
        errors.add(:player_blue)
		end
		if (player_red_score == player_blue_score) || ((player_red_score != 10) && (player_blue_score !=10)) 
			errors.add(:player_red_score)
			errors.add(:player_blue_score)
		end

	end

  def win?(id)
  	(player_red_id == id && player_red_score == 10) || (player_blue_id == id && player_blue_score == 10)
  end
end

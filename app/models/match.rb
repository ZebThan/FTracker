class Match < ActiveRecord::Base
  belongs_to :player_red, class_name: 'Player'
  belongs_to :player_blue, class_name: 'Player'

  validates :player_red_score, :numericality => { :only_integer => true, :less_than => 11, :greater_or_equal_to => 0}
  validates :player_blue_score, :numericality => { :only_integer => true, :less_than => 11, :greater_or_equal_to => 0}
end

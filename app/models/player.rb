class Player < ActiveRecord::Base

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "25x25>" }, :default_url => "avatars/:style/missing.jpg"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	validates :last_name, :length => {:in => 2...15}
  	validates :first_name, :length => {:in => 2...15}
  	validates :elo, :presence => :true


	def to_s
		first_name + " " + last_name
	end

	def wins
		@matches = Match.players_matches(id)
		wins = 0
			@matches.each do |match|
				if match.win?(id)
				wins = wins+1
				end
			end
	return wins
	end

	def loses
		@matches.size - wins
	end

	def ratio
		 if @matches.size == 0
		 	return @matches.size
		 end
		 r = (wins*100)/@matches.size
		return r

	end

	def win_streak
		matches = Match.players_matches(id)
		streak = 0
		longest_streak = 0

			matches.each do |match|
				if match.win?(id)
				streak = streak + 1
				else
					if (streak>longest_streak) 
						longest_streak = streak
					end
					streak = 0
				end
			end
		
		longest_streak
	end

	def avarage_points
		matches = Match.players_matches(id)
		points = 0
		matches.each do |match|
			if match.player_red_id = id
				points = points + match.player_red_score
			else
				points = points + match.player_blue_score
			end
		end
		points = points.to_f
		points = points/@matches.size
		return points.round(2)
	end

	def place_in_ranking
		players  = Player.where('elo>=?', elo).order('elo DESC')
		difference = 0
		players.reverse_each do |player|
			if player.id != id
				difference = difference + 1
			else
				break
			end
		end
        players.count - difference
	end

end

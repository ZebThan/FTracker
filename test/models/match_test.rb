require 'test_helper'

class MatchTest < ActiveSupport::TestCase

		test "should not save match if player red = player blue" do
			player_1 = Player.create(first_name: 'Adam', last_name: 'Nowak', elo: '100')
			match = Match.create(player_red_id: player_1.id, player_blue_id: player_1.id, player_blue_score: '10', player_red_score: '5')
			assert_not match.save, "Saved a match when player red = player blue"
		end
  
		test "scores" do
			player_1 = Player.create(first_name: 'Adam', last_name: 'Nowak', elo: '100')
			player_2 = Player.create(first_name: 'Jan', last_name: 'Kowalski', elo: '69')
			match = Match.create(player_red_id: player_1.id, player_blue_id: player_2.id)
	match.player_red_score = 10
	10.times do |n|
		match.player_blue_score = 3
		assert match.save, "Didn't save a match with valid score"
	end
	match.player_blue_score = 10
	10.times do |n|
		match.player_red_score = n-1
		assert match.save, "Didn't save a match with valid score"
	 end
	match.player_red_score = 10
	assert_not match.save, "Saved a match with with invalid 10:10 score"

	10.times do |n|
		match.player_red_score = n-1
		10.times do |m|
			match.player_blue_score=m-1
			assert_not match.save, "Saved a match with invalid score (noone got 10 points)"
		end
	end
	10.times do |n|
		match.player_red_score = n+10
		10.times do |m|
			match.player_blue_score = m+10
			assert_not match.save, "Saved a match with invalid score (players have more than 10 points)"
		end
	end

	match.player_red_score = 10
	10.times do |n|
		match.player_blue_score = n+10
		assert_not match.save, "Saved a match with invalid score (player blue got more than 10 points)"
	end
	match.player_blue_score = 10
	10.times do |n|
		match.player_red_score = n+10
		assert_not match.save, "Saved a match with invalid score (player red got more than 10 points)"
	end
	end
		
end

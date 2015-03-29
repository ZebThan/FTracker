require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

	setup do
	@p1 = Player.create(first_name: 'Adam', last_name: 'Nowak', elo: '1000')
	@p2 = Player.create(first_name: 'Jan', last_name: 'Kowalski', elo: '1000')
	@m = Array.new(20) {Match.new(player_red_id: @p1.id, player_blue_id: @p2.id)}
	end
   
   test "should not saved without, to long, or to short a first name" do
   	 player = Player.create(last_name: "test", elo: "50")
     assert_not player.save
     player = Player.create(first_name: "a", last_name: "test", elo: "50")
     assert_not player.save
     player = Player.create(first_name: "tolongtolongtolongtolongtolongtolongtolongtolong", last_name: "test", elo: "50")
     assert_not player.save
   end

     test "should not saved without, to long, or to short a last name" do
   	 player = Player.create(first_name: "test", elo: "50")
     assert_not player.save
     player = Player.create(first_name: "test", last_name: "a", elo: "50")
     assert_not player.save 
     player = Player.create(first_name: "test", last_name: "tolongtolongtolongtolongtolongtolongtolongtolong", elo: "50")
     assert_not player.save 
    end

     test "should not saved without an elo" do
   	 player = Player.create(first_name: "test", last_name: "test")
     assert_not player.save 
     end

     	test "win/lose counter, ratio" do
     		player_1 = @p1
     		player_2 = @p2
     		matches = @m
		10.times do |n|
			matches[n-1].player_red_score = 10
			matches[n-1].player_blue_score = n-1
		end
		10.times do |n|
			matches[n+9].player_red_score = n-1
			matches[n+9].player_blue_score = 10
		end
		matches.each do |match|
			match.save
		end
		assert_equal 10, player_1.wins, "Wrong number of wins for player red"
		assert_equal 10, player_2.wins, "Wrong number of wins for player blue"
		assert_equal 10, player_1.loses, "Wrong number of loses for player red"
		assert_equal 10, player_2.loses, "Wrong number of loses for player blue"
		assert_equal 50, player_1.ratio, "Wrong ratio for player red"
		assert_equal 50, player_2.ratio, "Wrong ratio for player blue"
		5.times do |n|
			matches[n+4].player_blue_score = 10
			matches[n+4].player_red_score = n
			matches[n+4].save
		end
		assert_equal 5, player_1.wins, "Wrong number of wins for player red"
		assert_equal 15, player_2.wins, "Wrong number of wins for player blue"
		assert_equal 15, player_1.loses, "Wrong number of loses for player red"
		assert_equal 5, player_2.loses, "Wrong number of loses for player blue"
		assert_equal 25, player_1.ratio, "Wrong ratio for player red"
		assert_equal 75, player_2.ratio, "Wrong ratio for player blue"
	end

	test "win streak" do
		player_1 = @p1
     		player_2 = @p2
     		matches = @m
		3.times do |n|
			matches[n-1].player_red_score = 10
			matches[n-1].player_blue_score = 5
		end
		5.times do |n|
			matches[n+2].player_red_score = 5
			matches[n+2].player_blue_score = 10
		end
		4.times do |n|
			matches[n+7].player_red_score = 10
			matches[n+7].player_blue_score = 5
		end
		6.times do |n|
			matches[n+11].player_red_score = 5
			matches[n+11].player_blue_score = 10
		end
		2.times do |n|
			matches[n+17].player_red_score = 10
			matches[n+17].player_blue_score = 5
		end

		matches.each do |match|
			match.save
		end
		assert_equal 4, player_1.win_streak, "Wrong streak for player red"
		assert_equal 6, player_2.win_streak, "Wrong streak for player blue"
	end



end

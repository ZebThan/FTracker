# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times  do
	p = Player.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, elo: 1000)
	puts "Player added"
	end

50.times do
	red_id = rand(1..20)
	blue_id = rand(1..20)
	until red_id != blue_id
	red_id = rand(1..20)
	end 
	m = Match.create(player_red_id: red_id, player_blue_id: blue_id, player_red_score: 10, player_blue_score: rand(0..9) )
	puts "Match added"
end	

50.times do
	red_id = rand(1..20)
	blue_id = rand(1..20)
	until red_id != blue_id
	red_id = rand(1..20)
	end 
	m = Match.create(player_red_id: red_id, player_blue_id: blue_id, player_red_score: rand(0..9), player_blue_score: 10 )
	"Match added"
end	

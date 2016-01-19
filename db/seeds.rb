# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Season.create(name: 'Winter 2016', is_current: true)
Game.create(opponent: 'Clusterpuck', game_date: (Time.now + (2*24*60*60)), result: "TBD")


chad = User.new(
  :first_name => "Chad",
  :last_name => "Ruble",
  :phone => "+19179684122",
  :email => "cruble4@gmail.com",
  :password => 'shufflestats'
)
chad.save!(:validate => false) 

steve = User.new(
  :first_name => "Steve",
  :last_name => "Miller",
  :phone => "+15167210895",
  :email => "smazin70@gmail.com",
  :password => 'shufflestats'
)
steve.save!(:validate => false)

adam = User.new(
  :first_name => "Adam",
  :last_name => "Lubinsky",
  :phone => "+13479711167",
  :email => "smazin70@examol.com",
  :password => 'shufflestats'
)
adam.save!(:validate => false)

sean = User.new(
  :first_name => "Sean",
  :phone => "+19172027554",
  :email => "sean@example.com",
  :password => 'shufflestats' 
)
sean.save!(:validate => false)


matt = User.new(
  :first_name => "Matt",
  :phone => "+19178655204",
  :email => "matt@example.com",
  :password => 'shufflestats' 
)
matt.save!(:validate => false)

first_game = Game.create(game_date: (Date.today - 7.days), result: "W", status: "closed", season_id: Season.last.id, opponent: "Shuffle Butter")

GamePlayer.create(game_id: first_game.id, user_id: matt.id)
GamePlayer.create(game_id: first_game.id, user_id: sean.id)
GamePlayer.create(game_id: first_game.id, user_id: adam.id)
GamePlayer.create(game_id: first_game.id, user_id: steve.id)

GameBench.create(game_id: first_game.id, user_id: chad.id)








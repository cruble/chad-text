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
  :first_name => "Lane",
  :last_name => "Miller",
  :phone => "+19175260975",
  :email => "smazin70@gmail.com",
  :password => 'shufflestats'
)
steve.save!(:validate => false)



# adam = User.new(
#   :first_name => "Adam",
#   :email => "adam@example.com",
#   :password => 'shufflestats'
# )
# adam.save!(:validate => false)

# sean = User.new(
#   :first_name => "Sean",
#   :email => "sean@example.com",
#   :password => 'shufflestats' 
# )
# sean.save!(:validate => false)


# matt = User.new(
#   :first_name => "Matt",
#   :email => "matt@example.com",
#   :password => 'shufflestats' 
# )
# matt.save!(:validate => false)



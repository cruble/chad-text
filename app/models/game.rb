class Game < ActiveRecord::Base
  belongs_to :season
  has_many :game_players
  has_many :game_benches 
  has_many :users, through: :game_players
  has_many :users, through: :game_benches

end

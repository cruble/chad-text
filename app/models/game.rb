class Game < ActiveRecord::Base
  belongs_to :season
  has_many :game_players, :dependent => :delete_all
  has_many :game_benches, :dependent => :delete_all 
  has_many :users, through: :game_players
  has_many :users, through: :game_benches

end

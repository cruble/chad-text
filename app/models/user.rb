class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :game_benches
  has_many :game_players 
  has_many :games, through: :game_players
  has_many :games, through: :game_benches

  def season_benched
    this_season = PlayerSeasonBenched.where(user_id: self.id, season_id: Season.last.id).count
    if this_season
      this_season
    else 
      0
    end
  end 

  def season_played 
    this_season = PlayerSeasonPlayed.where(user_id: self.id, season_id: Season.last.id).count
    if this_season
      this_season
    else 
      0
    end
  end 


end

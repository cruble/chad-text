class AddSeasonToGames < ActiveRecord::Migration
  def change
    add_reference :games, :season, index: true
    add_foreign_key :games, :seasons
  end
end

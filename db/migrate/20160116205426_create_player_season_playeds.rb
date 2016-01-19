class CreatePlayerSeasonPlayeds < ActiveRecord::Migration
  def change
    create_table :player_season_playeds do |t|
      t.references :season, index: true
      t.references :user, index: true
      t.integer :count

      t.timestamps null: false
    end
    add_foreign_key :player_season_playeds, :seasons
    add_foreign_key :player_season_playeds, :users
  end
end

class CreatePlayerSeasonBencheds < ActiveRecord::Migration
  def change
    create_table :player_season_bencheds do |t|
      t.references :season, index: true
      t.references :user, index: true
      t.integer :count

      t.timestamps null: false
    end
    add_foreign_key :player_season_bencheds, :seasons
    add_foreign_key :player_season_bencheds, :users
  end
end

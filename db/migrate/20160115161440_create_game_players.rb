class CreateGamePlayers < ActiveRecord::Migration
  def change
    create_table :game_players do |t|
      t.references :user, index: true
      t.references :game, index: true

      t.timestamps null: false
    end
    add_foreign_key :game_players, :users
    add_foreign_key :game_players, :games
  end
end

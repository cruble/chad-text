class CreateGameBenches < ActiveRecord::Migration
  def change
    create_table :game_benches do |t|
      t.references :user, index: true
      t.references :game, index: true

      t.timestamps null: false
    end
    add_foreign_key :game_benches, :users
    add_foreign_key :game_benches, :games
  end
end

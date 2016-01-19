class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :game_date
      t.string :opponent
      t.string :result

      t.timestamps null: false
    end
  end
end

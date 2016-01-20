class CreateNuggets < ActiveRecord::Migration
  def change
    create_table :nuggets do |t|
      t.string :tag
      t.text :content
      t.string :category

      t.timestamps null: false
    end
  end
end

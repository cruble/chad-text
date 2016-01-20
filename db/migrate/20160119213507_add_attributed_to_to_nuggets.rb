class AddAttributedToToNuggets < ActiveRecord::Migration
  def change
    add_column :nuggets, :attributed_to, :string
  end
end

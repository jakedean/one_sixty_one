class AddIndexToWants < ActiveRecord::Migration
  def change
  	add_index :wants, [:user_id, :item_id], unique: true
  end
end

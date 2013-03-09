class RemoveIndexFromWants < ActiveRecord::Migration
  def up
  	remove_index :wants, [:user_id, :item_id]
  end

  def down
  	add_index :wants, [:user_id, :item_id]
  end
end

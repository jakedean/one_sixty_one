class AddUseridToReactions < ActiveRecord::Migration
  def change
  	add_column :reactions, :user_id, :integer
  end
end

class AddColumnToReactions < ActiveRecord::Migration
  def change
    add_column :reactions, :item_id, :integer
  end
end

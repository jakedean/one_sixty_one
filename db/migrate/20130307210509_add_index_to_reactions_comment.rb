class AddIndexToReactionsComment < ActiveRecord::Migration
  def change
  	add_index :reactions, :comment
  end
end

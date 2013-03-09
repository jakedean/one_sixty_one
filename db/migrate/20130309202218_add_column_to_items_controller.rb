class AddColumnToItemsController < ActiveRecord::Migration
  def change
  	add_column :items, :counter, :integer, default: 0
  end
end

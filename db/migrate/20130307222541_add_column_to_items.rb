class AddColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :school_id, :integer
  end
end

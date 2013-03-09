class RemoveSchoolidFromItems < ActiveRecord::Migration
  def up
  	remove_column :items, :school_id
  end

  def down
  	add_column :items, :school_id
  end
end

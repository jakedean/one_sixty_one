class AddIndexOnUsersForSchool < ActiveRecord::Migration
  def up
  	add_index :users, :school_id
  end

  def down
  	remove_index :users, :school_id
  end
end

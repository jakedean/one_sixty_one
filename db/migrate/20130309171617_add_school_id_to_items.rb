class AddSchoolIdToItems < ActiveRecord::Migration
  def change
  	add_column :items, :school_id, :integer
  end
end

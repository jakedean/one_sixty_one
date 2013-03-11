class AddColumsToPersonal < ActiveRecord::Migration
  def change
  	add_index :personals, :want_id
  end
end

class AddUserColumnToPersonals < ActiveRecord::Migration
  def change
  	add_column :personals, :user_id, :integer
  end
end

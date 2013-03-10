class AddStatusColumnToWants < ActiveRecord::Migration
  def change
  	add_column :wants, :status, :integer, default: 0
  end

 
end

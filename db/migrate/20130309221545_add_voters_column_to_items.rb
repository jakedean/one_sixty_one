class AddVotersColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :voters, :integer
  end
end

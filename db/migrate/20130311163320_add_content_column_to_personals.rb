class AddContentColumnToPersonals < ActiveRecord::Migration
  def change
  	add_column :personals, :content, :string
  end
end

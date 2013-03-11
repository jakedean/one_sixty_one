class AddPictureColumnToWants < ActiveRecord::Migration
  def change
  	add_attachment :wants, :picture
  end
end

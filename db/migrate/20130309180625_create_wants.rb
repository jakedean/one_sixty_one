class CreateWants < ActiveRecord::Migration
  def change
    create_table :wants do |t|
      t.integer :user_id
      t.string :item_id

      t.timestamps
    end
    add_index :wants, :user_id
    add_index :wants, :item_id
    add_index :wants, [:user_id, :item_id], unique: true
  end
end

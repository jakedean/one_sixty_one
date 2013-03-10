class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :item_id
    add_index :votes, [:user_id, :item_id], unique: true
  end
end

class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.string :comment

      t.timestamps
    end
  end
end
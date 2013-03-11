class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
      t.integer :want_id

      t.timestamps
    end
  end
end

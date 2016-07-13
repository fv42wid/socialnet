class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :location

      t.timestamps null: false
    end
  end
end

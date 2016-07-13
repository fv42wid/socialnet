class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :profile_picture_id

      t.timestamps null: false
    end
  end
end

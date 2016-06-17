class AddUserAndBodyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :body, :string
    add_column :posts, :user_id, :integer
    add_foreign_key :posts, :users
  end
end

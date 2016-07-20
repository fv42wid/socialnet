class UpdateLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :post_id, :likable_id
    add_column :likes, :likeable_type, :string
  end
end

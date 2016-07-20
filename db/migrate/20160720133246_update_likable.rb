class UpdateLikable < ActiveRecord::Migration
  def change
    rename_column :likes, :likeable_type, :likable_type
  end
end

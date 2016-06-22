class FixNotifiableTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :notifications, :notifieable_type, :notifiable_type
  end
end

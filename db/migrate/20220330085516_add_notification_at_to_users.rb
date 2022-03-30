class AddNotificationAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notification_at, :string
  end
end

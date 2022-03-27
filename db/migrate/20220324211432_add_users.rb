class AddUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :qiita_user_id, :integer
  end
end

class ChangeDatatypeQiitaUserId0fUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :qiita_user_id, :string
  end
end

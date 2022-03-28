class AddDefalutToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :default_task_cycle, :integer
    add_column :users, :default_repeat_count, :integer
  end
end

class AddCompletedFlagToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :completed_flag, :boolean, default: false, null: false
  end
end

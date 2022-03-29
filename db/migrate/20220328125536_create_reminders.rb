class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.references :task, null: false, foreign_key: true
      t.integer :task_cycle, null: false
      t.integer :repeat_count, null: false

      t.timestamps
    end
  end
end

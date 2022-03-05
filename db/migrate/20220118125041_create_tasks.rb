class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :body
      t.date :start_date, null: false
      t.date :doing_date, null: false
      t.integer :task_state, null: false, default: 0

      t.timestamps
    end
  end
end

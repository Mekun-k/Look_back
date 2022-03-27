class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :task, null: false, foreign_key: true
      t.integer :qiita_id, null: false

      t.timestamps
    end
  end
end

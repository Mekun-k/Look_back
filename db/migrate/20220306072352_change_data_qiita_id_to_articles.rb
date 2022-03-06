class ChangeDataQiitaIdToArticles < ActiveRecord::Migration[6.1]
  def change
    change_column :articles, :qiita_id, :string
  end
end

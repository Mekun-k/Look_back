class AddArticlesToChoices < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :choice, :integer
  end
end

class ChangeArticles < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :articles, :text
  end
end
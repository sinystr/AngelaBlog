class AddActiveToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :active, :boolean, default: false
  end
end

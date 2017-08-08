class CreateArticles < ActiveRecord::Migration[5.1]
  def up
    create_table :articles do |t|
      t.string  :picture
      t.string  :title_bg
      t.string  :title_en
      t.string  :text_bg
      t.string  :text_en
    end
  end

  def down
    drop_table :articles
  end
end

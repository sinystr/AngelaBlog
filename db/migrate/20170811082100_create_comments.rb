class CreateComments < ActiveRecord::Migration[5.1]
  def up
    create_table :comments do |t|
      t.string   :text
      t.integer  :article_id
      t.integer  :user_id
    end
  end

  def down
    drop_table :comments
  end
end

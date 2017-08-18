class CreateTags < ActiveRecord::Migration[5.1]
  def up
    create_table :tags do |t|
      t.string :name
    end
  end

  def down
    drop_table :tags
  end
end

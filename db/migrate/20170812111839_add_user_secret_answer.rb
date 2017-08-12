class AddUserSecretAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :secret_answer, :string
  end
end

class AddProfileFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string
    add_column :users, :gender, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :phone_no, :string
  end
end

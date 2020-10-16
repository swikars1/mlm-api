class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :name, :string
  	add_column :users, :phone_no, :string
  	add_column :users, :role, :text
  	add_column :users, :gender, :string
  end
end

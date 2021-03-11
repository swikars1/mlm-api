class AddEmailToRetailer < ActiveRecord::Migration[5.2]
  def change
  	add_column :retailers, :email, :string
  end
end

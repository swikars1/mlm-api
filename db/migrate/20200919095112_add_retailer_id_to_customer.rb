class AddRetailerIdToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :retailer_id, :bigint
    add_column :customers, :user_id, :bigint
    add_column :customers, :parent_id, :bigint
  end
end

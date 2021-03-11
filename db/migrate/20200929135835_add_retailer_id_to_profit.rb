class AddRetailerIdToProfit < ActiveRecord::Migration[5.2]
  def change
    add_column :profits, :retailer_id, :bigint
  end
end

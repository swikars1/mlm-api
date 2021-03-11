class AddPercentToRetailer < ActiveRecord::Migration[5.2]
  def change
    add_column :retailers, :percent, :bigint
  end
end

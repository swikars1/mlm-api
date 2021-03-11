class AddQtyToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :qty, :float
  end
end

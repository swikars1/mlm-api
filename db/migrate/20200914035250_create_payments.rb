class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.bigint :customer_id, null: false
      t.bigint :retailer_id
      t.string :payment_name, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end

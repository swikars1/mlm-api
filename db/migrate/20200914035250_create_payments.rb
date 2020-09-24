# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.bigint :customer_id, null: false
      t.bigint :retailer_id
      t.bigint :product_id
      t.string :name, null: false
      t.float :expenditure, null: false

      t.timestamps
    end
  end
end

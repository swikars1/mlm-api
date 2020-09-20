# frozen_string_literal: true

class CreateRetailers < ActiveRecord::Migration[5.2]
  def change
    create_table :retailers do |t|
      t.string :name, null: false, index: true
      t.string :phone_no, null: false
      t.string :address
      t.string :pan_number
      t.bigint :retailer_type_id

      t.timestamps
    end
  end
end

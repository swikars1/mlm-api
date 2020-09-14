# frozen_string_literal: true

class CreateRetailers < ActiveRecord::Migration[5.2]
  def change
    create_table :retailers do |t|
      t.string :name, null: false, index: true
      t.string :contact_number, null: false
      t.string :address

      t.timestamps
    end
  end
end

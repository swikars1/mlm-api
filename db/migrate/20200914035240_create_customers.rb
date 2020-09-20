# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false, index: true
      t.string :email
      t.string :phone_no, null: false
      t.float :expenditure
      t.string :gender
      t.string :address
      t.date :birthday
      t.boolean :is_agent, default: false
      t.date :last_active_at

      t.timestamps
    end
  end
end

class AddFieldsToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :bill_no, :string
    add_column :payments, :cashback, :bigint
  end
end

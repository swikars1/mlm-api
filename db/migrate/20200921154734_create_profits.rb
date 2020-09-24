class CreateProfits < ActiveRecord::Migration[5.2]
  def change
    create_table :profits do |t|
      t.bigint :payment_id
      t.bigint :customer_id
      t.float :total_profit
      t.float :self_profit
      t.float :company_profit

      t.timestamps
    end
  end
end

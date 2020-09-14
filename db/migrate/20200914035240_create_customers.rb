class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false, index: true
      t.string :email
      t.bigint :contact_number, null: false
      t.float :expenditure
      t.boolean :agent, default: false
      t.date :last_active_at

      t.timestamps
    end
  end
end

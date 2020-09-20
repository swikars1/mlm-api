class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :type
      t.float :price
      t.bigint :qty
      t.bigint :retailer_id
      t.text :description

      t.timestamps
    end
  end
end

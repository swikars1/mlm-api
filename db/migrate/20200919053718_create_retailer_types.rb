class CreateRetailerTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :retailer_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end

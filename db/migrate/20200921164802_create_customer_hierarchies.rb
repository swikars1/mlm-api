class CreateCustomerHierarchies < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :customer_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "customer_anc_desc_idx"

    add_index :customer_hierarchies, [:descendant_id],
      name: "customer_desc_idx"
  end
end

class AddCodeToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :code, :text
  end
end

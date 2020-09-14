# frozen_string_literal: true

class CreateJwtDenylists < ActiveRecord::Migration[5.2]
  def change
    create_table :jwt_denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false

      t.timestamps
    end
    add_index :jwt_denylists, :jti
  end
end

# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :payments
  has_many :customers, foreign_key: 'parent_id'
  has_many :customer_products, dependent: :destroy
  has_many :products, through: :customer_products
  belongs_to :user
end

class Product < ApplicationRecord
  belongs_to :retailer, optional: true
  has_many :customer_products, dependent: :destroy
  has_many :customers, through: :customer_products
  has_many :payments

  has_one_attached :avatar
end

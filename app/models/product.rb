class Product < ApplicationRecord
  belongs_to :retailer, optional: true
end

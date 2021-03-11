class Profit < ApplicationRecord
  belongs_to :payment
  belongs_to :customer, optional: true
  belongs_to :retailer, optional: true
end

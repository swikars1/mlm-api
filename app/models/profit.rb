class Profit < ApplicationRecord
  belongs_to :payment
  belongs_to :customer, optional: true
end

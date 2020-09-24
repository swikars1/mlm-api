class Profit < ApplicationRecord
  belongs_to :payment, optional: true
end

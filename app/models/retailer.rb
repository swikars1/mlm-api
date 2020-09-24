# frozen_string_literal: true

class Retailer < ApplicationRecord
  has_many :customers
  has_many :products
  belongs_to :retailer_type
end

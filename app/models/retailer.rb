# frozen_string_literal: true

class Retailer < ApplicationRecord
  has_many :customers
  belongs_to :retailer_type
end

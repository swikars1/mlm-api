# frozen_string_literal: true

class Retailer < ApplicationRecord
  has_many :customers
  has_many :products
  has_many :payments
  belongs_to :retailer_type

  has_many_attached :avatars
end

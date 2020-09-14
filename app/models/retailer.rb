# frozen_string_literal: true

class Retailer < ApplicationRecord
  has_many :customers
end

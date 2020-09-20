# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :payments
  has_many :customers, foreign_key: 'parent_id'
  belongs_to :user
end

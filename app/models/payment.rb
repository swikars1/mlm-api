# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :product, optional: true
  belongs_to :retailer, optional: true
  has_one :profit
  has_one_attached :bill

  def distribute_profit(customer, params)
    retailer = Retailer.find(params[:retailer_id])
    main_profit = (params[:expenditure].to_f * retailer.percent.to_f) / 100
    profit = customer.profits.new
    profit.payment = self
    profit.total_profit = main_profit
    profit.retailer_id = params[:retailer_id]
    if customer.created_at.to_date > Time.zone.now.to_date - 1.month
      # first month
  
      profit.self_profit = 0
      profit.company_profit = main_profit / 2
      customer.ancestors.each do |a|
        next unless a.is_active

        a_profit = a.profits.new
        a_profit.payment = self
        a_profit.self_profit = (main_profit / 2) / customer.ancestors.count
        a_profit.save
      end
    else
      # after first month

      profit.self_profit = main_profit * 0.25
      profit.company_profit = main_profit / 2
      customer.ancestors.each do |a|
        next unless a.is_active

        a_profit = a.profits.new
        a_profit.payment = self
        a_profit.self_profit = (main_profit * 0.25) / customer.ancestors.count
        a_profit.save
      end
    end
    profit.save
  end
end

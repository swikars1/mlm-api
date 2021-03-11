# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :product, optional: true
  belongs_to :retailer, optional: true
  has_many :profits
  has_one_attached :bill

  PROFIT_LIMIT = 5000

  def distribute_profit(customer, params)
    retailer = Retailer.find(params[:retailer_id])
    main_profit = (params[:expenditure].to_f * retailer.percent.to_f) / 100
    profit = customer.profits.new
    profit.payment = self
    profit.total_profit = main_profit
    profit.retailer_id = params[:retailer_id]
    active_ancestors_count = 0
    all_parents_inactive_flag = customer.ancestors.map(&:is_active).none?(true)
    customer.ancestors.each { |a| a.is_active ? active_ancestors_count += 1 : '' }
    if customer.created_at.to_date > Time.zone.now.to_date - 1.month
      # first month
    
      profit.self_profit = 0
      profit.company_profit = all_parents_inactive_flag ? main_profit : main_profit / 2
      customer.ancestors.each do |a|
        next unless a.is_active

        a_profit = a.profits.new
        a_profit.payment = self
        a_profit.self_profit = (main_profit / 2) / active_ancestors_count
        a_profit.save
      end
    else
      # after first month

      if customer.expenditure.to_f >= PROFIT_LIMIT
        profit.self_profit = main_profit * 0.25
        profit.company_profit = all_parents_inactive_flag ? main_profit * 0.75 : main_profit / 2
      else
        profit.self_profit = 0
        profit.company_profit = all_parents_inactive_flag ? main_profit : main_profit * 0.75
      end
      customer.ancestors.each do |a|
        next unless a.is_active

        a_profit = a.profits.new
        a_profit.payment = self
        a_profit.self_profit = (main_profit * 0.25) / active_ancestors_count
        a_profit.save
      end
    end
    profit.save
  end
end

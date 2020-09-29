# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :retailer, optional: true
  has_one :profit

  CASHBACK_LIMIT = 10_000 # to determine later

  def distribute_profit(customer, params, product)
    price_of_product = product.price.to_f
    # this needs chage as the profit rule is not currently known

    main_profit = price_of_product * 0.15 * params[:qty].to_f

    profit = customer.profits.new
    profit.payment = self
    profit.total_profit = main_profit
    profit.retailer_id = params[:retailer_id]

    # cashbask scheme
    if customer.is_agent && customer.descendants.empty?
      profit.company_profit = main_profit
      if customer.expenditure >= CASHBACK_LIMIT
        profit.self_profit = main_profit / 2
        profit.company_profit = main_profit / 2
        profit.retailer_id = params[:retailer_id]
      end
      profit.save
    else
      distribute_profit_to_parent(customer, main_profit, params)
    end
  end

  def distribute_profit_to_parent(customer, main_profit, params)
    # updating immediate parent profit
    customer.parent && (
      immediate_parent = customer.parent
      immediate_parent_profit = immediate_parent.profits.new
      immediate_parent_profit.payment = self
      immediate_parent_profit.total_profit = main_profit
      immediate_parent_profit.self_profit = main_profit * 0.25
      immediate_parent_profit.retailer_id = params[:retailer_id]
      immediate_parent_profit.save
    )

    if no_client_is_agent(customer)
      ancestor_except_immediate = customer.ancestors.reject { |a| a.id == customer.parent_id }
      !ancestor_except_immediate.empty? && ancestor_except_immediate.each do |a|
        a_profit = a.profits.new
        a_profit.payment = self
        a_profit.total_profit = main_profit
        a_profit.self_profit = (main_profit * 0.25) / ancestor_except_immediate.count
        a_profit.save
      end
    else
      profit = customer.profits.new
      profit.payment = self
      profit.total_profit = main_profit
      profit.self_profit = main_profit / 2
      profit.company_profit = main_profit / 2
      profit.retailer_id = params[:retailer_id]
      profit.save
    end
  end
  
  def no_client_is_agent(customer)
    customer.descendants.none? { |d| d.is_agent == true }
  end
end

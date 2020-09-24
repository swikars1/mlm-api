# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :customer
  has_one :profit

  CASHBACK_LIMIT = 10_000

  def distribute_profit(customer, params)
    price_of_product = Product.find(params[:product_id]).price
    main_profit = price_of_product * 0.15

    profit = customer.profits.new
    profit.payment = self
    profit.total_profit = main_profit

    # cashbask scheme
    if customer.is_agent && customer.descendants.empty?
      profit.company_profit = main_profit
      if customer.expenditure >= CASHBACK_LIMIT
        profit.self_profit = main_profit / 2
        profit.company_profit = main_profit / 2
      end
      profit.save
    else
      distribute_profit_to_parent(customer, main_profit)
    end
  end

  def distribute_profit_to_parent(customer, main_profit)
    # updating immediate parent profit
    customer.parent && (
      immediate_parent = customer.parent
      immediate_parent_profit = immediate_parent.profits.new
      immediate_parent_profit.total_profit = main_profit
      immediate_parent_profit.self_profit = main_profit * 0.25
      immediate_parent_profit.save
    )

    if no_client_is_agent(customer)
      ancestor_except_immediate = customer.ancestors.reject { |a| a.id == customer.parent_id }
      !ancestor_except_immediate.empty? && ancestor_except_immediate.each do |a|
        a_profit = a.profits.new
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
      profit.save
    end
  end
  
  def no_client_is_agent(customer)
    customer.descendants.none? { |d| d.is_agent == true }
  end
end

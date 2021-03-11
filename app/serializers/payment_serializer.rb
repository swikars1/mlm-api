class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :expenditure, :customer, :retailer, :percent, :cashback,
             :self_profit, :company_profit, :each_parent_profit, :profit_parent_count

  def customer
  	object.customer&.name || 'DELETED'
  end

  def retailer
  	object.retailer&.name
  end

  def percent
    object.retailer&.percent || 0
  end

  def cashback
    (object.expenditure * (object.retailer&.percent.to_f / 100)).to_f.round(2)
  end

  def self_profit
    object.profits.where(customer_id: object.customer_id).sum(:self_profit).to_f.round(2) || 0
  end

  def company_profit
    object.profits.where(customer_id: object.customer_id).sum(:company_profit).to_f.round(2) || 0
  end

  def each_parent_profit
    object.profits.where.not(customer_id: object.customer_id).sample&.self_profit&.to_f&.round(2) || 0
  end

  def profit_parent_count
    object.profits.where.not(customer_id: object.customer_id)&.count || 0
  end
end
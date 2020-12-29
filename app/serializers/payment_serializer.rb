class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :expenditure, :customer, :retailer, :percent, :cashback

  def customer
  	object.customer.name
  end

  def retailer
  	object.retailer&.name
  end

  def percent
    object.retailer&.percent
  end

  def cashback
    object.expenditure * (object.retailer&.percent.to_f / 100)
  end
end
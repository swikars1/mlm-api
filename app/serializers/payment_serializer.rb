class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :expenditure, :customer, :retailer, :product

  def customer
  	object.customer.name
  end

  def retailer
  	object.retailer&.name
  end

  def product
  	object.product&.name
  end
end
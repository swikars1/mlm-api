class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :retailer, :code

  def retailer
  	object.retailer.name
  end
end

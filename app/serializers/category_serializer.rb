class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :products

  def products
    object.products.first(10)
  end
end

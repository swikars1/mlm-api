class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :code, :image_url, :retailer, :category,

  def retailer
  	object.retailer&.name
  end

  def category
  	object.categories
  end

  def image_url
 	object.image_url(object.avatar)
  end
end

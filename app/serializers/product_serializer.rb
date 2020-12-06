class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :code, :image_url, :retailer_name, :categories, :retailer_id

  def retailer_name
  	object.retailer&.name
  end

  def retailer_id
    object.retailer&.id
  end

  def categories
  	object.categories
  end

  def image_url
 	  object.image_url(object.avatar)
  end
end

class RetailerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_no, :email, :address, :pan_number, :retailer_type, :percent, :image_url

  def retailer_type
  	object.retailer_type.name
  end

  def image_url
  	object.image_url(object.avatar)
  end
end

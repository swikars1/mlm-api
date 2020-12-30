class RetailerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_no, :email, :address, :pan_number, :retailer_type, :percent, :avatars

  def retailer_type
  	object.retailer_type.name
  end

  def avatars
    return unless object&.avatars.attached?
    
    object.image_list_url(object.avatars)
  end

end

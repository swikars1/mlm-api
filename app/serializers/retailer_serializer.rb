class RetailerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_no, :address, :pan_number, :retailer_type

  def retailer_type
  	object.retailer_type.name
  end
end

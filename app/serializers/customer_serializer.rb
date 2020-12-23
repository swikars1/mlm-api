class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday, :expenditure, :refer_code, :image_url, :bills

  def image_url
  	object.image_url(object.user.avatar)
  end

  def bills
    return unless object.bills.attached?
    
    object.image_list_url(object.bills)
  end
end

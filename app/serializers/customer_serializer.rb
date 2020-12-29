class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday, :expenditure, :refer_code, :image_url,
             :bills, :front_url, :back_url, :status

  def image_url
  	object.image_url(object.user.avatar)
  end

  def bills
    return unless object.bills.attached?
    
    object.image_list_url(object.bills)
  end

  def front_url
    object.image_url(object.id_front)
  end

  def back_url
    object.image_url(object.id_back)
  end

  def status
    object.is_active ? 'Active' : 'Inactive'
  end

end

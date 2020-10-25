class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday, :expenditure, :refer_code, :image_url

  def image_url
  	object.image_url(object.user.avatar)
  end
end

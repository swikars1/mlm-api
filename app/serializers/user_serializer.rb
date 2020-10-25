class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :role, :image_url

  def image_url
  	object.image_url(object.avatar)
  end
end

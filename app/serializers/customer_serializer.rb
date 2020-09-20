class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday
end

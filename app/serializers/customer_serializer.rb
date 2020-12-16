class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday, :expenditure, :refer_code, :image_url, :bills

  def image_url
  	object.image_url(object.user.avatar)
  end

  def bills
    bill_urls = object.bills.map do |bill|
      object.image_url(bill)
    end
    bill_urls
  end
end

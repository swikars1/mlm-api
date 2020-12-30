class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_no, :gender, :address, :birthday, :expenditure, :refer_code, :image_url,
             :bills, :front_url, :back_url, :status, :todays_income, :monthly_income

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

  def todays_income
    object.profits.where('created_at between ? and ?', Time.zone.now.beginning_of_day, Time.zone.now)
          .sum(:self_profit).round(2)
  end

  def monthly_income
    object.profits.where('created_at between ? and ?', Time.zone.now - 1.month, Time.zone.now).sum(:self_profit).round(2)
  end

  def status
    object.is_active ? 'Active' : 'Inactive'
  end
end

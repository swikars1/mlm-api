class CustomerDeactivateJob < ApplicationJob
  def perform
    Customer.where.not('last_active_at between ? and ?', Time.zone.now - 6.months, Time.zone.now).each do |a|
      a.last_active_at = nil
      a.save
    end
  end
end

class Api::V1::DashboardController < ApplicationController
  def widgets
    widgets = {
      total_customers: Customer.all.count,
      total_retailers: Retailer.all.count,
      total_products: Product.all.count,
      today_income: Profit.where('created_at between ? and ?', Time.zone.now - 1.day, Time.zone.now)
                          .sum(:company_profit),
      monthly_income: Profit.where('created_at between ? and ?', Time.zone.now - 1.month, Time.zone.now)
                            .sum(:company_profit),
      total_income: Profit.sum(:company_profit)
    }
    render json: { data: widgets }
  end

  def gender_pie_chart
    pie_data = [
      {
        name: 'Male',
        value: Customer.where('gender ilike ?', 'male').count
      },
      {
        name: 'Female',
        value: Customer.where('gender ilike ?', 'female').count
      }
    ]
    render json: { data: pie_data }
  end
end

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

  def line_chart
    i = 11
    line_data = []
    x_axis = []
    10.times do
      i -= 1
      line_data.push(Profit.where('created_at between ? and ?', Time.zone.now - i.days, Time.zone.now - (i - 1).days)
               .sum(:company_profit))
      x_axis.push((Time.zone.now - i.days).strftime('%b %d'))
    end
    final = {
      x_axis: x_axis,
      line_data: line_data
    }
    render json: { data: final }
  end
end

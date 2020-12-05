class Api::V1::DashboardController < ApplicationController
  def widgets
    widgets = {
      total_customers: Customer.all.count,
      total_retailers: Retailer.all.count,
      total_categories: Category.all.count,
      total_products: Product.all.count
    }
    render json: { data: widgets }
  end
end

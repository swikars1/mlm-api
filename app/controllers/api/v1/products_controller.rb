class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    products = products.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    products = products.where(retailer_id: params[:retailer_id]) if params[:retailer_id]
    render json: { data: products }, status: :ok
  end
end

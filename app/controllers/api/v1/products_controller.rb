class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    products = Product.where('name ilike ?', "%#{params[:q]}%") unless params[:q].empty?
    render json: { data: products }, status: :ok
  end
end

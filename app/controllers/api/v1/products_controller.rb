class Api::V1::ProductsController < ApplicationController
  def index
    render json: { data: Product.all }, status: :ok
  end
end

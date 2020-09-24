class Api::V1::RetailersController < ApplicationController
  def index
    render json: { data: Retailer.all }
  end

  def create
    retailer = Retailer.new(retailer_params)
    if retailer.save
      render json: { data: retailer }, status: :ok
    else
      render json: { errors: retailer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def retailer_params
    params.permit(:name, :pan_number, :phone_no, :retailer_type_id)
  end
end

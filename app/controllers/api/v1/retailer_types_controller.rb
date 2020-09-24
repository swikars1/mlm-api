class Api::V1::RetailerTypesController < ApplicationController
  def index
    render json: { data: RetailerType.all }, status: :ok
  end

  def create
    retailer_type = RetailerType.new(retailer_type_params)
    if retailer_type.save
      render json: { data: retailer_type }, status: :ok
    else
      render json: { errors: retailer_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def retailer_type_params
    params.permit(:name, :pan_number, :phone_no)
  end
end

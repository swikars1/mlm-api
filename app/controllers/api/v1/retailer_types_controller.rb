class Api::V1::RetailerTypesController < ApplicationController
  def index
    retailer_types = RetailerType.all
    retailer_types = RetailerType.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    render_all(datas: retailer_types)
  end

  def create
    retailer_type = RetailerType.new(retailer_type_params)
    if retailer_type.save
      render json: { data: retailer_type }, status: :ok
    else
      render json: { errors: retailer_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
   render_success(data: RetailerType.find(params[:id]), status: 200)
  end

  def destroy
    retailer_type = RetailerType.find(params[:id])
    if retailer_type.destroy
      render_all(datas: RetailerType.all)
    else
      render json: { errors: retailer_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    retailer_type = RetailerType.find(params[:id])
    if retailer_type.update(retailer_type_params)
      render json: { data: retailer_type }, status: :ok
    else
      render json: { errors: retailer_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def retailer_type_params
    params.require(:retailer_type).permit(:name)
  end
end

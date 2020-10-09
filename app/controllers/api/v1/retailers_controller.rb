class Api::V1::RetailersController < ApplicationController
  def index
    retailer_products_query = "(select json_agg(distinct jsonb_build_object(
      'name', products.name,
      'id', products.id,
      'price', products.price
    )) from products where products.retailer_id = retailers.id) as product_list"

    retailer_type_query = '(select name
      from retailer_types where retailer_types.id = retailers.retailer_type_id)
      as retailer_type_name'
  
    retailers = Retailer.select('retailers.*')
                        .select(retailer_products_query)
                        .select(retailer_type_query).as_json
    retailers = Retailer.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    render json: { data: retailers }, status: :ok
  end

  def show
    render_success(data: Retailer.find(params[:id]), status: 200)
  end

  def create
    retailer = Retailer.new(retailer_params)
    if retailer.save
      render json: { data: retailer }, status: :ok
    else
      render json: { errors: retailer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    retailer = Retailer.find(params[:id])
    if retailer.update(retailer_params)
      render_success(data: Retailer.find(params[:id]), status: 200)
    else
      render json: { errors: retailer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    retailer = Retailer.find(params[:id])
    if retailer.destroy
      render json: { data: Retailer.all }, status: :ok
    else
      render json: { errors: retailer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def payments
    payments = Retailer.joins(payments: :product)
                       .joins(payments: :customer)
                       .select('payments.*')
                       .select('products.name as product_name')
                       .select('products.id as product_id')
                       .where('retailers.id = ?', params[:id])
                       .where('customers.id = ?', params[:customer_id])
                       .as_json
    render json: { data: payments }, status: :ok
  end

  private

  def retailer_params
    params.require(:retailer).permit(:name, :pan_number, :phone_no, :retailer_type_id, :address)
  end
end

class Api::V1::RetailersController < ApplicationController
  def index
    retailers = Retailer.all
    if !params[:q]&.empty?
      retailers = Retailer.where('name ilike ? ', "%#{params[:q]}%")
                          .or(Retailer.where(id: params[:q]))
                          .or(Retailer.where('email ilike ?', "%#{params[:q]}%"))
                          .or(Retailer.where('phone_no ilike ?', "%#{params[:q]}%"))
                          .or(Retailer.where('pan_number ilike ?', "%#{params[:q]}%"))
    end
    render_all(datas: retailers)

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

  def upload_image
    retailer = Retailer.find(params['id'])
    if retailer.avatars.attach(params['image'])
      render_success(data: retailer, status: 200)
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

  def products
    retailer = Retailer.find(params[:id])
    render json: { data: retailer.products }, status: :ok
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
    params.require(:retailer).permit(:name, :pan_number, :phone_no, :email, :retailer_type_id, :address, :percent)
  end
end

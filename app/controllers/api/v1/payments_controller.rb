class Api::V1::PaymentsController < ApplicationController
  def index
  	# binding.pry
    payments = Payment.all
    payments = payments.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    # payments = payments.where(retailer_id: params[:retailer_id]) if params[:retailer_id]
    # payments = payments.where(product_id: params[:product_id]) if params[:product_id]
    # payments = payments.where(customer_id: params[:customer_id]) if params[:customer_id]
    render json: { data: payments }, status: :ok
  end

  def show
    render_success(data: Payment.find(params[:id]), status: 200)
  end

  def create
    customer = Customer.find(params[:payment][:customer_id])
    customer.handle_payment(params[:payment])
    render json: { data: Payment.all }, status: :ok
  end

  def destroy
    payment = Payment.find(params[:id])
    if payment.destroy
      render json: { data: Payment.all }, status: :ok
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def payment_params
  	params.require(:payment).permit(:customer_id, :retailer_id, :product_id, :name, :expenditure)
  end

end


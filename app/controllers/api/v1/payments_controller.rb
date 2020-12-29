class Api::V1::PaymentsController < ApplicationController
  def index
    payments = Payment.all
    payments = payments.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    payments = payments.where(customer_id: params[:customer_id]) if params[:customer_id]
    render_all(datas: payments)
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
      render_all(datas: Payment.all)
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def payment_params
  	params.require(:payment).permit(:customer_id, :retailer_id, :product_id, :name, :expenditure)
  end

end


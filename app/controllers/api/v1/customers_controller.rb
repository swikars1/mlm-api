class Api::V1::CustomersController < ApplicationController
  def index
    render json: { data: Customer.all }, status: :ok
  end

  def show
    render json: { data: Customer.find(params[:id]) }, status: :ok
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(update_params)
      render json: { data: customer }, status: :ok
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    user = User.create!(email: params[:email], password: params[:password])
    customer = Customer.new(customer_params)
    customer.user = user
    if customer.save
      render json: { data: customer }, status: :ok
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def clients
    customer = Customer.find(params[:id])
    render json: { data: customer.customers }, status: :ok
  end

  private

  def customer_params
    params.permit(:name, :email, :phone_no, :gender, :address, :birthday,
                  :parent_id)
  end

  def update_params
    params.permit(:phone_no, :address)
  end
end

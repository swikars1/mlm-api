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
    customer = Customer.new(name: params[:name], email: params[:email], phone_no: params[:phone_no],
                            gender: params[:gender], address: params[:address], birthday: params[:birthday])

    customer.parent = Customer.find_by(refer_code: params[:refer_code]) if params[:refer_code]
    customer.user = user
    if customer.save
      customer.handle_payment(params)
      render json: { data: customer }, status: :ok
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def clients
    customer = Customer.find(params[:id])
    render json: { data: customer.children }, status: :ok
  end

  def add_payment
    customer = Customer.find(params[:id])
    customer.handle_payment(params)
    render json: { data: customer }, status: :ok
  end

  def profits
    customer = Customer.find(params[:id])
    profits = customer.profits
    render json: { data: profits }, status: :ok
  end

  def update_params
    params.permit(:phone_no, :address)
  end
end

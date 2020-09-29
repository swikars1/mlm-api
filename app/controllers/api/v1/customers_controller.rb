class Api::V1::CustomersController < ApplicationController
  def index
    render_all(datas: Customer.all)
  end

  def show
    render_success(data: Customer.find(params[:id]), status: 200)
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(update_params)
      render_success(data: Customer.find(params[:id]), status: 200)
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
    clients = Customer.where('customers.parent_id = ?', params[:id])
    render_all(datas: clients)
  end

  def add_payment
    customer = Customer.find(params[:id])
    customer.handle_payment(params)
    render_success(data: customer, status: 200)
  end

  def profits
    profits = Profit.left_outer_joins(payment: :product)
                    .left_outer_joins(:customer)
                    .select('profits.*')
                    .select('products.name as  product_name')
                    .select('payments.expenditure')
                    .where('profits.id is not null')
                    .where('customers.id = ?', params[:id])
                    .as_json
    render json: { data: profits }, status: :ok
  end

  def payments
    payments = Customer.left_outer_joins(payments: :product)
                       .left_outer_joins(payments: :retailer)
                       .select('payments.*')
                       .select('products.name as product_name')
                       .select('retailers.name as retailer_name')
                       .where('payments.id is not null')
                       .where('customers.id = ?', params[:id])
                       .as_json
    render json: { data: payments }, status: :ok
  end

  def update_params
    params.permit(:phone_no, :address)
  end
end

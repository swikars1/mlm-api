class Api::V1::CustomersController < ApplicationController
  def index
    customers = Customer.all
    customers = Customer.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    render_all(datas: customers)
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
    user = User.create!(email: customer_params[:email], password: customer_params[:password],
                        name: customer_params[:name], phone_no: customer_params[:phone_no],
                        gender: customer_params[:gender], role: 'customer')
    customer = Customer.new(name: customer_params[:name], email: customer_params[:email],
                            phone_no: customer_params[:phone_no], gender: customer_params[:gender],
                            address: customer_params[:address], birthday: customer_params[:birthday])

    customer.parent = Customer.find_by(refer_code: customer_params[:refer_code]) if customer_params[:refer_code]
    customer.user = user
    if customer.save
      customer.handle_payment(customer_params)
      render json: { data: customer }, status: :ok
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    if customer.destroy
      render_all(datas: Customer.all)
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
    customer.handle_payment(params[:customer])
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

  def upload_bill
    customer = Customer.find(params['id'])
    customer.bill.attach(params['image'])
    if customer.bill.attach(params['image'])
      render_success(data: customer, status: 200)
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def my_profits
    customer = Customer.find(params[:id])
    render json: { data: customer.profits }, status: :ok
  end

  def update_params
    params.require(:customer).permit(:name, :phone_no, :birthday, :address)
  end

  def customer_params
    params.require(:customer)
  end
end

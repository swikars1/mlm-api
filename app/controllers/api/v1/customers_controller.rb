class Api::V1::CustomersController < ApplicationController
  def index
    customers = Customer.all
    if !params[:q]&.empty?
      customers = Customer.where('name ilike ?', "%#{params[:q]}%")
                          .or(Customer.where('email ilike ?', "%#{params[:q]}%"))
                          .or(Customer.where('phone_no ilike ?', "%#{params[:q]}%"))
                          .or(Customer.where(id: params[:q]))
    end
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

    customer.parent = Customer.first || nil
    customer.user = user
    if customer.save
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
                       .select('products.price as product_price')
                       .select('retailers.name as retailer_name')
                       .where('payments.id is not null')
                       .where('customers.id = ?', params[:id])
                       .as_json
    render json: { data: payments }, status: :ok
  end

  def upload_bill
    customer = Customer.find(params['id'])
    if customer.bills.attach(params['image'])
      render_success(data: customer, status: 200)
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_image
    customer = Customer.find(params[:id])
    if params[:type] == 'front'
      customer.id_front.attach(params['image'])
    else
      customer.id_back.attach(params['image'])
    end
    render_success(data: customer, status: 200)
  end

  def my_profits
    customer = Customer.find(params[:id])
    render json: { data: customer.profits }, status: :ok
  end

  def search_all
    search_params = params[:q]
    render json: { data: search_maker('product', search_params) +
                         search_maker('retailer', search_params) +
                         search_maker('category', search_params) }, status: :ok
  end

  def search_maker(model_name, search_params)
    query = "select id, name, '#{model_name}' as type from #{model_name.pluralize} where name ilike '%#{search_params}%'"
    ActiveRecord::Base.connection.execute(query).as_json
  end

  def update_params
    params.require(:customer).permit(:name, :phone_no, :birthday, :address, :gender)
  end

  def customer_params
    params.require(:customer)
  end
end

class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    products = products.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    products = products.where(retailer_id: params[:retailer_id]) if params[:retailer_id]
    render_all(datas: products)
  end

  def show
    render_success(data: Product.find(params[:id]), status: 200)
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: { data: product }, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render_success(data: Product.find(params[:id]), status: 200)
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_image
    product = Product.find(params['id'])
    product.avatar.attach(params['image'])
    if product.avatar.attach(params['image'])
      render_success(data: product, status: 200)
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def recent
    render_all(datas: Product.order(:created_at).first(10), each_serializer: ::ProductSerializer, response_all: true)
  end

  def featured
    render_all(datas: Product.order(:updated_at).first(10), each_serializer: ::ProductSerializer, response_all: true)
  end

  def popular
    render_all(datas: Product.all.sample(15), each_serializer: ::ProductSerializer, response_all: true)
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      render json: { data: Product.all }, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def product_params
    params.require(:product).permit :name, :price, :description, :retailer_id, :code, category_ids: []
  end

end


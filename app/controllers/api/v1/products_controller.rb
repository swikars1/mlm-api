class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    products = products.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    products = products.where(retailer_id: params[:retailer_id]) if params[:retailer_id]
    render json: { data: products }, status: :ok
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
  	params.require(:product).permit :name, :price, :description, :retailer_id, :code
  end

end


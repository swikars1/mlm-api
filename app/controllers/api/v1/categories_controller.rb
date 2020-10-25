class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    categories = Category.where('name ilike ?', "%#{params[:q]}%") unless params[:q]&.empty?
    render json: { data: categories }, status: :ok
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: { data: category }, status: :ok
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
   render_success(data: Category.find(params[:id]), status: 200)
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      render json: { data: Category.all }, status: :ok
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      render json: { data: category }, status: :ok
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

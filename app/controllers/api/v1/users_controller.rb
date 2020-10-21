class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: { data: users }, status: :ok
  end

  def show
    render_success(data: User.find(params[:id]), status: 200)
  end

  def create
    user = User.new(payment_params)
    if user.save
      render json: { data: user }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(payment_params)
      render_success(data: User.find(params[:id]), status: 200)
    else
      render json: { errors: User.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def upload_image
    user = User.find(params['id'])
    user.avatar.attach(params['image'])
    if user.avatar.attach(params['image'])
      render_success(data: user, status: 200)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { data: User.all }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
  	params.require(:user).permit(:email, :name, :gender, :role, :phone_no)
  end

end


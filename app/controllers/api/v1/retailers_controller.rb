class Api::V1::RetailersController < ApplicationController
  def index
    render json: { data: Retailer.all }
  end
end

class Api::V1::RetailerTypesController < ApplicationController
  def index
    render json: { data: RetailerType.all }, status: :ok
  end
end

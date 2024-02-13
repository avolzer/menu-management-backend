class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    render json: @restaurants, status: :ok
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: @restaurant, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
end

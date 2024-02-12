class MenusController < ApplicationController
  def index
    @menus = Menu.all
    render json: @menus, status: :ok
  end

  def show
    @menu = Menu.find(params[:id])
    render json: @menu, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
end

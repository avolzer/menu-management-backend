class MenuItemsController < ApplicationController
  def index
    menu_items = MenuItem.all
    render json: menu_items, status: :ok
  end

  def show
    menu_item = MenuItem.find(params[:id])
    render json: menu_item, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
end

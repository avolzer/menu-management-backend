class MenusController < ApplicationController
  def index
    menus = Menu.all
    render json: menus, status: :ok
  end

  def show
    menu = Menu.find(params[:id])
    items = menu.prices.map{|p| {name: p.menu_item.name, price: p.price}}
    render json: {id: menu.id, name: menu.name, restaurant_id: menu.restaurant_id, menu_items: items}, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end
end

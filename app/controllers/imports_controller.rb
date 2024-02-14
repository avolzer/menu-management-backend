class ImportsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    data = JSON.parse(params[:file].read)
    menu_items = []
    data["restaurants"].each do |r|
      restaurant = Restaurant.create(name: r["name"])

      r["menus"].each do |m|
        menu = Menu.create(name: m["name"], restaurant: restaurant)

        items = m["menu_items"] || m["dishes"]

        items.each do |mi|
          item = MenuItem.where(name: mi["name"]).first_or_create
          price = Price.create(price: mi["price"], menu_item: item, menu: menu)
          menu_items.append({item: item.name, price: price.price, menu: menu.name, restaurant: restaurant.name})
        end
      end
    end

    render json: { "Menu Items": menu_items }, status: :ok
  end
end

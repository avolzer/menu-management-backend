class ImportsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    begin
      data = JSON.parse(params[:file].read)
      
      menu_items = []
      unless data["restaurants"]
        render json: { error: 'Missing restaurants data' }, status: :bad_request
        return
      end
      data["restaurants"].each do |r|
        restaurant = Restaurant.create(name: r["name"])

        if r["menus"] then
          r["menus"].each do |m|
            menu = Menu.create(name: m["name"], restaurant: restaurant)

            items = m["menu_items"] || m["dishes"]
            
            if items != nil then
              items.each do |mi|
                # MenuItems cannot have duplicate names
                item = MenuItem.where(name: mi["name"]).first_or_create
                price = Price.create(price: mi["price"], menu_item: item, menu: menu)
                menu_items.append({item: item.name, price: '%.2f' %price.price, menu: menu.name, restaurant: restaurant.name})
              end
            end
          end
        end
      end

      render json: { "Menu Items Added": menu_items }, status: :ok

    rescue JSON::ParserError
      render json: { error: 'Invalid JSON' }, status: :bad_request
    end
  end
end

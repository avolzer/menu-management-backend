require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
  describe "GET /menu_items" do
    it "returns a list of all menu items" do
      item = create(:menu_item)
      get menu_items_path
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(1)
      expect(parsed_body[0]["name"]).to eq(item.name)
      expect(parsed_body[0]["price"].to_d).to eq(item.price)
    end
  end

  describe "GET /menu_items/:id" do
    context "menu with given id exists" do
      it "returns menu" do
        item = create(:menu_item)
        get menu_item_path(item.id)
        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["name"]).to eq(item.name)
        expect(parsed_body["price"].to_d).to eq(item.price)
      end
    end
    context "menu item with given id exists" do
      it "returns 404 not found" do
        get menu_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

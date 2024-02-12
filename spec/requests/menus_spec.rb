require 'rails_helper'

RSpec.describe "Menus", type: :request do
  describe "GET /menus" do
    it "returns a list of all menus" do
      menu = create(:menu)
      get menus_path
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(1)
      expect(parsed_body[0]["name"]).to eq(menu.name)
    end
  end

  describe "GET /menus/:id" do
    context "menu with given id exists" do
      it "returns menu" do
        menu = create(:menu)
        get menu_path(menu.id)
        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["name"]).to eq(menu.name)
      end
    end
    context "menu with given id exists" do
      it "returns 404 not found" do
        get menu_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

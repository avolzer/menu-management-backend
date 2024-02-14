require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /restaurants" do
    it "returns a list of all restaurants" do
      restaurant = create(:restaurant)
      get restaurants_path
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(1)
      expect(parsed_body[0]["name"]).to eq(restaurant.name)
    end
  end

  describe "GET /restaurants/:id" do
    context "restaurant with given id exists" do
      it "returns restaurant" do
        restaurant = create(:restaurant)
        get restaurant_path(restaurant.id)
        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["name"]).to eq(restaurant.name)
      end
    end
    context "restaurant with given id does not exist" do
      it "returns 404 not found" do
        get restaurant_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

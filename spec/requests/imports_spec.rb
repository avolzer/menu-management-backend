require 'rails_helper'

RSpec.describe "Imports", type: :request do
  describe "POST /imports" do
    context "given a valid json file" do
      let(:json_file) { fixture_file_upload(file_fixture('restaurant_data.json')) }
      let(:expected_log) {[{"item"=>"Burger", "price"=>"9.00", "menu"=>"lunch", "restaurant"=>"Poppo's Cafe"},
                          {"item"=>"Small Salad", "price"=>"5.00", "menu"=>"lunch", "restaurant"=>"Poppo's Cafe"},
                          {"item"=>"Burger", "price"=>"15.00", "menu"=>"dinner", "restaurant"=>"Poppo's Cafe"},
                          {"item"=>"Large Salad", "price"=>"8.00", "menu"=>"dinner", "restaurant"=>"Poppo's Cafe"},
                          {"item"=>"Chicken Wings", "price"=>"9.00", "menu"=>"lunch", "restaurant"=>"Casa del Poppo"},
                          {"item"=>"Burger", "price"=>"9.00", "menu"=>"lunch", "restaurant"=>"Casa del Poppo"},
                          {"item"=>"Chicken Wings", "price"=>"9.00", "menu"=>"lunch", "restaurant"=>"Casa del Poppo"},
                          {"item"=>"Mega \"Burger\"", "price"=>"22.00","menu"=>"dinner","restaurant"=>"Casa del Poppo"},
                          {"item"=>"Lobster Mac & Cheese","price"=>"31.00","menu"=>"dinner","restaurant"=>"Casa del Poppo"}]}

      it "inserts items into database and returs a log of all items" do
        post imports_path, params: {file: json_file}
        expect(response).to have_http_status(200)

        expect(Restaurant.count).to eq(2);
        expect(Menu.count).to eq(4);
        expect(Price.count).to eq(9);
        expect(MenuItem.count).to eq(6);
        
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["Menu Items Added"]).to eq(expected_log)
      end
    end

    context "given an invalid json file" do
      let(:json_file) { fixture_file_upload(file_fixture('restaurant_data_invalid.json')) }

      it "returns a bad request status" do
        post imports_path, params: {file: json_file}
        expect(response).to have_http_status(400)
      end
    end

    context "given a file without restaurant data" do
      let(:json_file) { fixture_file_upload(file_fixture('restaurant_data_incomplete.json')) }

      it "returns a bad request status" do
        post imports_path, params: {file: json_file}
        expect(response).to have_http_status(400)
      end
    end
  end
end

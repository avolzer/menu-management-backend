require 'rails_helper'

RSpec.describe "ImportsController", type: :request do
  describe "POST /imports" do
    let(:json_file) { fixture_file_upload(file_fixture('restaurant_data.json')) }

    it "inserts items into database" do
      post imports_path, params: {file: json_file}
      expect(response).to have_http_status(200)
      expect(Restaurant.count).to eq(2);
      expect(Menu.count).to eq(4);
      expect(Price.count).to eq(9);
      expect(MenuItem.count).to eq(6);
    end
  end
end

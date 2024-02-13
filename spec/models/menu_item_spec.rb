require 'rails_helper'

RSpec.describe MenuItem, :type => :model do
  it "must have a unique name" do
    burger = create(:menu_item)
    expect(burger).to be_valid
    expect(build(:menu_item, name: "burger")).to_not be_valid
  end
end
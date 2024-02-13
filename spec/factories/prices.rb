FactoryBot.define do
  factory :price do
    price { 5.00 }
    menu_item
    menu
  end
end
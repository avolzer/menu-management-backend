FactoryBot.define do
  factory :menu_item do
    name { "burger" }
    price { 5.00 }
    menu
  end
end
class Menu < ApplicationRecord
  has_many :prices
  has_many :menu_items, through: :prices
  belongs_to :restaurant
end

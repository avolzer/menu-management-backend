class MenuItem < ApplicationRecord
  validates_uniqueness_of :name
  
  has_many :prices
  has_many :menus, through: :prices
end

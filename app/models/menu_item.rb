class MenuItem < ApplicationRecord
  validates_uniqueness_of :name
  
  has_many :menus, through: :prices
end

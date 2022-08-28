class Category < ApplicationRecord
  validates :name, presence: true, length: 3..50
  validates :discount_percent, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 100 }
  validates :department, presence: true

  enum department: { misc: 0, grocery: 1, beverage: 2, apparel: 3, houseware: 4, electronics: 5 }

  has_many :products
end

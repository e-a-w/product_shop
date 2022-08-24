class Product < ApplicationRecord
  validates :name, presence: true, length: 3..50
  validates :description, length: { maximum: 200 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

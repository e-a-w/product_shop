class Product < ApplicationRecord
  validates :name, presence: true, length: 3..50
  validates :description, length: { maximum: 200 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :category

  delegate :department, to: :category

  scope :by_department, ->(dept) { Product.joins(:category).merge(Category.send(dept)) }
  scope :by_category, ->(category) { Product.joins(:category).merge(Category.where(name: category)) }

  def display_attributes
    attributes.except!('category_id').tap do |attr|
      attr['price'] = formatted_price
      attr['name'] = attr['name'].upcase
      attr['created_at'] = format_date(attr['created_at'])
      attr['updated_at'] = format_date(attr['updated_at'])
      attr['last_sold_at'] = format_date(attr['last_sold_at'])
    end
  end

  def formatted_price
    "$#{'%.2f' % (price.to_i / 100.0)}"
  end

  def display_name
    name.upcase
  end

  def format_date(date)
    return unless date.present?

    date.utc.strftime("%A %b %-d, %l:%M%P %z").squish
  end
end

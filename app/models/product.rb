class Product < ApplicationRecord
  validates :name, presence: true, length: 3..50
  validates :description, length: { maximum: 200 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :category
  has_many :feature_windows

  delegate :department, :discount_percent, to: :category

  scope :by_department, ->(dept) { joins(:category).merge(Category.send(dept)) }
  scope :by_category, ->(category) { joins(:category).merge(Category.where(name: category)) }
  scope :discounted, -> { joins(:category).merge(Category.discounted).where('price > 0') }
  scope :featured, -> { joins(:feature_windows).merge(FeatureWindow.active) }

  def display_attributes
    attrs = attributes.except!('category_id').tap do |attr|
      attr['price'] = formatted_price_in_dollars
      if discounted?
        attr['discount_price'] = formatted_discount_price
        attr['discount_percent'] = formatted_discount
      end
      attr['name'] = attr['name'].upcase
      attr['created_at'] = format_date(attr['created_at'])
      attr['updated_at'] = format_date(attr['updated_at'])
      attr['last_sold_at'] = format_date(attr['last_sold_at'])
    end

    attrs.inject([]) do |acc, (k, v)|
      if %w[discount_price discount_percent].include?(k)
        idx = acc.index({ "price" => formatted_price_in_dollars })
        idx += k == 'discount_price' ? 1 : 2
        acc.insert(idx, { k => v })
      else
        acc << { k => v }
      end
    end
  end

  def discounted?
    discount_percent.positive? && price > 0
  end

  def featured?
    feature_windows.active.exists?
  end

  def feature_end_date
    feature_windows.order(end_date: :desc).first.end_date.strftime("%F")
  end

  def display_name
    name.upcase
  end

  def formatted_discount
    "#{discount_percent}% off"
  end

  def formatted_price_in_dollars
    format_price(price_in_dollars)
  end

  def formatted_discount_price
    discount = price_in_dollars * (discount_percent / 100.0)
    discount_price = price_in_dollars - discount
    format_price(discount_price.round(2))
  end

  def format_date(date)
    return unless date.present?

    date.utc.strftime("%A %b %-d, %l:%M%P %z").squish
  end

  private

  def price_in_dollars
    price.to_i / 100.0
  end

  def format_price(price)
    "$#{'%.2f' % price}"
  end
end

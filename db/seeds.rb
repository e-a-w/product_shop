puts '===== starting... ====='

def category_name(category, idx)
  val = case category
        when 'grocery'
          %w[snacks dairy breakfast baking produce]
        when 'beverage'
          %w[water juice soda health liquor]
        when 'apparel'
          %w[shoes jewelry athletic swim coats]
        when 'houseware'
          %w[kitchen stationery decor storage furniture]
        when 'electronics'
          %w[computers headphones phones cameras television]
        else
          %w[pets toys outdoor holiday cafe]
        end

  val[idx]
end

puts '===== deleting tables ====='
Category.delete_all
Product.delete_all
FeatureWindow.delete_all


puts '===== creating CATEGORIES ====='
Category.departments.each do |category, i|
  5.times do |j|
    Category.create!(
      name: category_name(category, j),
      department: i,
      discount_percent: (j % 3).zero? ? 0 : rand(99)
    )
  end
end


puts '===== creating PRODUCTS and FEATURE WINDOWS ====='
Category.find_each do |category|
  30.times do |j|
    product = Product.create!(
      category_id: category.id,
      name: Faker::Commerce.unique.product_name,
      description: (j % 3).zero? ? nil : Faker::Company.catch_phrase,
      price: Faker::Number.within(range: 50..15_000),
      quantity: Faker::Number.within(range: 0..100),
      last_sold_at: Faker::Date.between(from: 1.year.ago, to: Date.yesterday),
      created_at: Faker::Date.between(from: 1.year.ago, to: 6.months.ago),
      updated_at: Faker::Date.between(from: 6.months.ago, to: Date.yesterday)
    )

    next unless (j % 5).zero?

    featured = (j % 3).zero?

    FeatureWindow.create!(
      featured: featured,
      product: product,
      start_date: Faker::Date.between(from: 6.months.ago, to: Date.yesterday),
      end_date: Faker::Date.between(from: 6.months.ago, to: 1.year.from_now)
    )
  end
end

puts '===== done ====='

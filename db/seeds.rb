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

Category.delete_all
Product.delete_all

Category.departments.each do |category, i|
  5.times do |j|
    Category.create!(
      name: category_name(category, j),
      department: i,
      discount_percent: (j % 3).zero? ? 0 : rand(99)
    )
  end
end

Category.find_each do |category|
  30.times do |j|
    Product.create(
      category_id: category.id,
      name: Faker::Commerce.unique.product_name,
      description: (j % 3).zero? ? nil : Faker::Company.catch_phrase,
      price: Faker::Number.within(range: 1..150),
      quantity: Faker::Number.within(range: 0..100),
      last_sold_at: Faker::Date.between(from: 1.year.ago, to: Date.yesterday)
    )
  end
end

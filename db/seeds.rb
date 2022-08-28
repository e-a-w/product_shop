def random_category_name(category, idx)
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

        puts category, idx, val[idx], "\n\n"
  val[idx]
end

Category.delete_all
Product.delete_all

Category.departments.each do |category, i|
  5.times do |j|
    Category.create(
      name: random_category_name(category, j),
      department: i,
      discount_percent: (j % 3).zero? ? nil : rand(99)
    )
  end
end

50.times do |i|
  Product.create(
    name: Faker::Commerce.unique.product_name,
    description: (i % 3).zero? ? Faker::Company.catch_phrase : nil,
    price: Faker::Number.within(range: 1..150),
    quantity: Faker::Number.within(range: 0..100),
    last_sold_at: Faker::Date.between(from: 1.year.ago, to: Date.yesterday)
  )
end

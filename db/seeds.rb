50.times do |i|
  Product.create(
    name: Faker::Commerce.unique.product_name,
    description: (i % 3).zero? ? Faker::Company.catch_phrase : nil,
    price: Faker::Number.within(range: 1..150),
    quantity: Faker::Number.within(range: 0..100),
    last_sold_at: Faker::Date.between(from: 1.year.ago, to: Date.yesterday)
  )
end

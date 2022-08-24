FactoryBot.define do
  factory :product do
    name { 'cool beans' }
    description { 'a handful of beanz' }
    price { 50 }
    quantity { 10 }
    last_sold_at { 5.days.ago }
  end
end

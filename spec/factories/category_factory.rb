FactoryBot.define do
  factory :category do
    name { 'snacks' }
    department { 'grocery' }
    discount_percent { 0 }
  end
end

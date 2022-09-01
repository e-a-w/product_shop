FactoryBot.define do
  factory :feature_window do
    association :product, factory: :product
    featured { true }
    start_date { DateTime.current.utc }
    end_date { DateTime.current.utc + 5.days }
  end
end

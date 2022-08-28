require "rails_helper" 

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:department) }
    it { should validate_presence_of(:discount_percent) }

    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }

    it { should validate_numericality_of(:discount_percent).is_greater_than_or_equal_to(0).is_less_than(100).only_integer }
  end
end

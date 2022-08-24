require "rails_helper" 

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }

    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:description).is_at_most(200) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0).only_integer }
  end
end

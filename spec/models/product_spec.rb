require "rails_helper" 

RSpec.describe Product, type: :model do
  let(:date) { DateTime.parse('12-11-10 10:30:45 +0700') }
  let(:product) do
    create(:product,
    name: 'my product',
    description: 'about this product',
    price: '150',
    quantity: 10,
    created_at: date,
    updated_at: date + 5.minutes,
    last_sold_at: date + 10.minutes)
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }

    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:description).is_at_most(200) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0).only_integer }
  end

  describe 'display methods' do
    context '#display_attributes' do
      subject { product.display_attributes.deep_symbolize_keys }

      it { expect(subject.keys.size).to eq(8) }
      it { expect(subject[:id]).to eq(product.id) }
      it { expect(subject[:name]).to eq('MY PRODUCT') }
      it { expect(subject[:description]).to eq('about this product') }
      it { expect(subject[:price]).to eq('$1.50') }
      it { expect(subject[:quantity]).to eq(10) }
      it { expect(subject[:updated_at]).to eq('Saturday Nov 10, 3:35am +0000') }
      it { expect(subject[:created_at]).to eq('Saturday Nov 10, 3:30am +0000') }
      it { expect(subject[:last_sold_at]).to eq('Saturday Nov 10, 3:40am +0000') }
    end
  end

  describe 'scopes' do
    let(:category) { create(:category, name: 'snacks', department: 'grocery') }
    let(:category2) { create(:category, name: 'pets', department: 'misc') }
    let(:category3) { create(:category, name: 'toys', department: 'misc') }

    let(:product) { create(:product, category: category) }
    let(:product2) { create(:product, category: category2) }
    let(:product3) { create(:product, category: category3) }
    let(:product4) { create(:product, category: category3) }

    context '#by_department' do
      it { expect(Product.by_department('misc')).to contain_exactly(product2, product3, product4) }
    end

    context '#by_category' do
      it { expect(Product.by_category('toys')).to contain_exactly(product3, product4) }
    end
  end
end

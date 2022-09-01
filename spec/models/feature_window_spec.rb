require "rails_helper" 

RSpec.describe FeatureWindow, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe 'scopes' do
    let(:active_window) { create(:feature_window, featured: true, start_date: DateTime.current.utc, end_date: DateTime.current.utc + 5.days) }
    let(:inactive_window) { create(:feature_window, featured: false, start_date: DateTime.current.utc, end_date: DateTime.current.utc + 5.days) }
    let(:expired_window) { create(:feature_window, featured: true, start_date: DateTime.current.utc, end_date: DateTime.current.utc - 5.days) }
    let(:unstarted_window) { create(:feature_window, featured: true, start_date: DateTime.current.utc + 2.days, end_date: DateTime.current.utc + 5.days) }

    before { freeze_time }
    after { travel_back }

    it { expect(FeatureWindow.expired).to contain_exactly(expired_window) }
    it { expect(FeatureWindow.active).to contain_exactly(active_window) }
  end
end

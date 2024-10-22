RSpec.describe Vehicle do
  subject(:vehicle) { build(:vehicle) }

  describe 'relationships' do
    it { is_expected.to have_many(:parkings) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:plate) }
  end
end

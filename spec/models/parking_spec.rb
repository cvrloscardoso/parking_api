RSpec.describe Parking do
  subject(:parking) { build(:parking) }

  describe 'relationships' do
    it { is_expected.to belong_to(:vehicle) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entry_time) }

    context '#paid' do
      subject(:paid_parking) { build(:parking, paid: true) }
      subject(:invalid_parking) { build(:parking, paid: nil) }

      it { expect(parking).to be_valid }
      it { expect(paid_parking).to be_valid }
      it { expect(invalid_parking). to be_invalid }
    end
  end

  describe '#unpaid?' do
    context 'when parking is not paid' do
      it { expect(parking.unpaid?).to be_truthy }
    end

    context 'when parking is paid' do
      before { parking.pay! }

      it { expect(parking.unpaid?).to be_falsey }
    end
  end

  describe '#pay!' do
    it { expect { parking.pay! }.to change { parking.paid }.from(false).to(true) }
  end

  describe '#exit!' do
    it { expect { parking.exit! }.to change { parking.exit_time }.from(nil) }
  end
end

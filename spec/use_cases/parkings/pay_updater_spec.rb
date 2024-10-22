RSpec.describe Parkings::PayUpdater do
  describe '.perform' do
    let(:parking) { create(:parking) }
    let(:parking_id) { parking.id }

    subject { described_class.perform(parking_id) }

    context 'when parking is not found' do
      let(:parking_id) { 0 }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when parking is found' do
      it 'updates parking paid attribute' do
        expect { parking.pay! }.to change(parking, :paid).from(false).to(true)
      end

      context 'when parking is already paid' do
        before { parking.pay! }

        it 'raises an error' do
          expect { subject }.to raise_error(StandardError, 'Parking already paid')
        end
      end
    end
  end
end

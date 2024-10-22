RSpec.describe Parkings::OutUpdater do
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

    context 'when parking is not paid' do
      it 'raises an error' do
        expect { subject }.to raise_error(StandardError, 'Parking must be paid')
      end
    end

    context 'when parking is paid' do
      before { parking.pay! }

      it 'updates parking exit time' do
        expect { parking.exit! }.to change(parking, :exit_time).from(nil).to(be_present)
      end
    end
  end
end

RSpec.describe Parkings::Creator do
  describe '.perform' do
    let(:plate) { 'MLA-1234' }
    let(:created_parking) { Parking.last }

    subject { described_class.perform(plate) }

    before { allow(Vehicles::Creator).to receive(:perform).with(plate).and_call_original }

    context 'when vehicle does not exist' do
      let(:vehicle) { Vehicle.last }

      it 'creates a vehicle with plate and create parking' do
        freeze_time do
          expect { subject }.to change { Parking.count }.by(1).and change { Vehicle.count }.by(1)

          expect(created_parking.vehicle).to eq(vehicle)
          expect(created_parking.entry_time).to eq(DateTime.current)
        end
      end
    end

    context 'when vehicle already exist' do
      let!(:vehicle) { create(:vehicle, plate: plate) }
      let(:created_parking) { Parking.last }

      it 'finds and uses a existent vehicle with plate and create parking' do
        freeze_time do
          expect { subject }.to change { Parking.count }.by(1).and change { Vehicle.count }.by(0)

          expect(created_parking.vehicle).to eq(vehicle)
          expect(created_parking.entry_time).to eq(DateTime.current)
        end
      end
    end
  end
end

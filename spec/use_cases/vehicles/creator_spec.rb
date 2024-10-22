RSpec.describe Vehicles::Creator do
  describe '.perform' do
    context 'when plate is invalid' do
      subject { described_class.perform('ABC-12345') }

      it 'raises an error' do
        expect { subject }.to raise_error(ArgumentError, 'Invalid vehicle plate').
          and not_change { Vehicle.count }
      end
    end

    context 'when plate is valid' do
      subject { described_class.perform('ABC-1234') }

      it 'creates a vehicle with correct plate' do
        expect { subject }.to not_raise_error.and change { Vehicle.count }.by(1)
        expect(Vehicle.last.plate).to eq('ABC-1234')
      end
    end
  end
end

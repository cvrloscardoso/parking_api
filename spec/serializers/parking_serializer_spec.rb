RSpec.describe ParkingSerializer do
  describe '#as_json' do
    let(:entry_time) { Time.new(2024, 10, 21, 12, 0, 0) }
    let(:exit_time) { Time.new(2024, 10, 21, 12, 30, 0) }
    let(:parking) { create(:parking, :paid, entry_time: entry_time, exit_time: exit_time) }

    subject { described_class.new(parking).as_json }

    it do
      is_expected.to eq({
        id: parking.id,
        time: '30 minutes',
        paid: true,
        left: true
      })
    end
  end
end

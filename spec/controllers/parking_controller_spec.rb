RSpec.describe ParkingController, type: :request do
  describe '#show' do
    subject(:show_request) { get "/parking/#{vehicle_plate}" }

    context 'when vehicle plate exists' do
      let(:vehicle) { create(:vehicle) }
      let(:vehicle_plate) { vehicle.plate }
      let!(:parkings_array) do
        [create(:parking, vehicle: vehicle), create(:parking, vehicle: vehicle)]
      end
      let(:serialized_parkings) { parkings_array.map { |parking| ParkingSerializer.new(parking).as_json } }

      it do
        show_request

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(serialized_parkings.to_json)
      end
    end

    context 'when vehicle plate does not exist' do
      let(:vehicle_plate) { 'ABC-1234' }

      it do
        show_request

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Record not found' }.to_json)
      end
    end
  end

  describe '#create' do
    subject(:create_request) { post '/parking', params: { plate: plate } }

    context 'when plate is valid' do
      let(:plate) { 'ABC-1234' }

      it do
        create_request

        expect(response).to have_http_status(:created)
        expect(response.body).to eq({ parking_id: Parking.last.id }.to_json)
      end
    end

    context 'when plate is invalid' do
      let(:plate) { 'ABC-12345' }

      it do
        create_request

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ error: 'Invalid vehicle plate' }.to_json)
      end
    end
  end

  describe '#out' do
    subject(:out_request) { put "/parking/#{parking_id}/out" }

    context 'when parking is not found' do
      let(:parking_id) { 0 }

      it do
        out_request

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Record not found' }.to_json)
      end
    end

    context 'when parking is found' do
      let(:parking) { create(:parking, :paid) }
      let(:parking_id) { parking.id }

      it do
        out_request

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({}.to_json)
      end

      context 'when parking is not paid' do
        let(:parking) { create(:parking) }
        let(:parking_id) { parking.id }

        it do
          out_request

          expect(response).to have_http_status(:bad_request)
          expect(response.body).to eq({ error: 'Parking must be paid' }.to_json)
        end
      end
    end
  end

  describe '#pay' do
    subject(:pay_request) { put "/parking/#{parking_id}/pay" }

    context 'when parking is not found' do
      let(:parking_id) { 0 }

      it do
        pay_request

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq({ error: 'Record not found' }.to_json)
      end
    end

    context 'when parking is found' do
      let(:parking) { create(:parking) }
      let(:parking_id) { parking.id }

      it do
        pay_request

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({}.to_json)
      end
    end
  end
end

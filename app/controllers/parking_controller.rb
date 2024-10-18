class ParkingController < ApplicationController
  def create
    parking = create_parking

    render json: { parking_id: parking.id }, status: :created
  end

  def show
    render json: parkings_by_plate, each_serializer: ParkingSerializer, status: :ok
  end

  def out
    Parkings::OutUpdater.perform(parking_id)

    render json: {}, status: :ok
  end

  def pay
    Parkings::PayUpdater.perform(parking_id)

    render json: {}, status: :ok
  end

  private

  def create_parking
    Parkings::Creator.perform(vehicle_plate).parking
  end

  def parkings_by_plate
    @parkings_by_plate ||= Vehicle.find_by(plate: vehicle_plate).parkings
  end

  def vehicle_plate
    @vehicle_plate = params[:plate]
  end

  def parking_id
    @parking_id = params[:id]
  end
end

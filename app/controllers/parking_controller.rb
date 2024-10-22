class ParkingController < ApplicationController
  rescue_from StandardError, with: :standard_error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error_handler

  def show
    render json: parkings_by_plate, each_serializer: ParkingSerializer, status: :ok
  end

  def create
    parking = create_parking

    render json: { parking_id: parking.id }, status: :created
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
    @vehicle = Vehicle.find_by!(plate: vehicle_plate).parkings
  end

  def vehicle_plate
    params[:plate].try(:upcase)
  end

  def parking_id
    params[:id]
  end

  def record_not_found_error_handler(_error)
    render json: { error: 'Record not found' }, status: :not_found
  end

  def standard_error_handler(error)
    render json: { error: error.message }, status: :bad_request
  end
end

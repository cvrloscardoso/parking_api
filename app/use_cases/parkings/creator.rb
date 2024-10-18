module Parkings
  class Creator
    include UseCase

    attr_reader :parking

    def initialize(vehicle_plate)
      @vehicle_plate = vehicle_plate
    end

    def perform
      ApplicationRecord.transaction do
        find_or_create_vehicle!
        create_parking
      end
    end

    private

    attr_reader :vehicle_plate, :vehicle

    def find_or_create_vehicle!
      @vehicle =
        Vehicle.find_by(plate: vehicle_plate).presence ||
          Vehicles::Creator.perform(vehicle_plate).vehicle
    end

    def create_parking
      @parking = Parking.create!(
        entry_time: DateTime.current,
        vehicle: vehicle
      )
    end
  end
end

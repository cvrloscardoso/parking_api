module Vehicles
  class Creator
    include UseCase

    attr_reader :vehicle

    def initialize(plate)
      @plate = plate
    end

    def perform
      create_vehicle
    end

    private

    attr_reader :plate

    def create_vehicle
      @vehicle = Vehicle.create!(plate: plate)
    end
  end
end

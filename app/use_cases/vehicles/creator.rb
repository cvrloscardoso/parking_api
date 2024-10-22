module Vehicles
  class Creator
    include UseCase

    attr_reader :vehicle

    def initialize(plate)
      @plate = plate
    end

    def perform
      validate!
      create_vehicle
    end

    private

    attr_reader :plate

    def validate!
      raise ArgumentError, 'Invalid vehicle plate' unless plate.match?(/\A[A-Z]{3}-[A-Z0-9]{4}\z/)
    end

    def create_vehicle
      @vehicle = Vehicle.create!(plate: plate)
    end
  end
end

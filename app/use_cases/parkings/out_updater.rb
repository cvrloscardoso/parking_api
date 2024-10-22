module Parkings
  class OutUpdater
    include UseCase

    def initialize(parking_id)
      @parking_id = parking_id
    end

    def perform
      validate!
      parking.exit!
    end

    private

    attr_reader :parking_id

    def validate!
      raise StandardError, 'Parking must be paid' if parking.unpaid?
    end

    def parking
      @parking = Parking.find(parking_id)
    end
  end
end

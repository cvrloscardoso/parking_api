module Parkings
  class PayUpdater
    include UseCase

    def initialize(parking_id)
      @parking_id = parking_id
    end

    def perform
      validate!
      parking.pay!
    end

    private

    attr_reader :parking_id

    def validate!
      raise StandardError, 'Parking already paid' if parking.paid?
    end

    def parking
      @parking = Parking.find(parking_id)
    end
  end
end

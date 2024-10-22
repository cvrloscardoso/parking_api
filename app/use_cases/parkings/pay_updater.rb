module Parkings
  class PayUpdater
    include UseCase

    def initialize(parking_id)
      @parking_id = parking_id
    end

    def perform
      parking.pay!
    end

    private

    attr_reader :parking_id

    def parking
      @parking = Parking.find(parking_id)
    end
  end
end

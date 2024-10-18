module Parkings::Validator
  def validate!
    raise ArgumentError, 'Invalid parking id' if parking.blank?
  end
end

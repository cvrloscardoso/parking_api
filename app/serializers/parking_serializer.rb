class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :time, :paid, :left

  SECONDS_IN_ONE_HOUR = 3600

  def time
    formatted_time
  end

  def left
    object.exit_time.present?
  end

  private

  def formatted_time
    seconds = object.exit_time - object.entry_time

    hours = (seconds / SECONDS_IN_ONE_HOUR).to_i
    minutes = ((seconds % SECONDS_IN_ONE_HOUR) / 60).to_i

    time = []

    time << "#{hours} horas" if hours.positive?
    time << "#{minutes} minutos"

    time.join(', ')
  end
end

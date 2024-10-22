class Parking < ApplicationRecord
  belongs_to :vehicle

  validates :entry_time, presence: true

  def unpaid?
    !paid
  end

  def pay!
    update!(paid: true)
  end

  def exit!
    update!(exit_time: DateTime.current)
  end
end

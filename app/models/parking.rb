class Parking < ApplicationRecord
  belongs_to :vehicle

  validates :paid, inclusion: { in: [true, false] }
  validates :entry_time, presence: true
end

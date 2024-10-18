class Vehicle < ApplicationRecord
  has_many :parkings

  validates :plate, presence: true
end

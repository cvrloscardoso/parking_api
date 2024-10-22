class Vehicle < ApplicationRecord
  has_many :parkings

  validates :plate, presence: true, format: { with: /\A[A-Z]{3}-[A-Z0-9]{4}\z/ }
  validates :plate, uniqueness: true
end

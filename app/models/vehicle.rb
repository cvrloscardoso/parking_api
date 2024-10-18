class Vehicle < ApplicationRecord
  has_many :parkings

  validates :plate, presence: true, format: { with: /\A[A-Z]{3}-\d{4}\z/ }
end

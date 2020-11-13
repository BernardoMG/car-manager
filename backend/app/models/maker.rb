class Maker < ApplicationRecord
  has_many :models
  has_many :cars
end

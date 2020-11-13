class Maker < ApplicationRecord
  has_many :models
  has_many :cars

  validates :name, presence: { message: 'can\'t be blank.' }
end

class Maker < ApplicationRecord
  has_many :models
  has_many :cars

  validates :name, presence: { message: 'Can\'t be blank.' }
end

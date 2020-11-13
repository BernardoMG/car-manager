class Color < ApplicationRecord
  has_many :cars
  has_many :model_colors
  has_many :models, through: :model_colors

  validates :name, presence: { message: 'can\'t be blank.' }
  validates :code, presence: { message: 'can\'t be blank.' }
end

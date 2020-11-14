class Color < ApplicationRecord
  has_many :cars
  has_many :model_colors
  has_many :models, through: :model_colors

  validates :name, presence: { message: 'Can\'t be blank.' }
  validates :code, presence: { message: 'Can\'t be blank.' }
end

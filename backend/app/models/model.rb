class Model < ApplicationRecord
  belongs_to :maker
  has_many :cars
  has_many :model_colors
  has_many :colors, through: :model_colors

  validates :name, presence: { message: 'Can\'t be blank.' }
end

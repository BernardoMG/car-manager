class Model < ApplicationRecord
  belongs_to :makers
  has_many :cars
  has_many :colors, through: model_colors
end

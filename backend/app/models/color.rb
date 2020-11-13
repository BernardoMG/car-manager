class Color < ApplicationRecord
  has_many :cars
  has_many :models, through: model_colors
end

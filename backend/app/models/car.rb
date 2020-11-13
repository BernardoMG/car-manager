class Car < ApplicationRecord
  belongs_to :color
  belongs_to :model
  belongs_to :maker
end

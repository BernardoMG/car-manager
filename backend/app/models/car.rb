class Car < ApplicationRecord
  belongs_to :color
  belongs_to :model
  belongs_to :maker

  validates :available_from, presence: { message: 'can\'t be blank.' }
  validates :year, presence: { message: 'can\'t be blank.' }
  validates :monthly, presence: { message: 'can\'t be blank.' }
end

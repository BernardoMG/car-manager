class Car < ApplicationRecord
  belongs_to :color
  belongs_to :model
  belongs_to :maker

  validate :model_is_available_on_the_requested_color

  validate :available_from_date_format

  validates :year, numericality:
                    {
                      only_integer: true,
                      message: 'Not a valid year. Please ensure that you are sending year parameter (a valid integer).'
                    }

  validates :monthly, numericality:
                        {
                          message: 'Not a valid monthly. Please ensure that you are sending monthly parameter (a valid number).'
                        }

  private

  def model_is_available_on_the_requested_color
    return false if color_id.blank? || model_id.blank?

    colors = model.colors.where(id: color_id).pluck(:id)

    return true if colors.size.positive?

    errors.delete(:color)
    errors.add(
      :color,
      'Model does not exists on the requested color. Please, first check all the available model colors.'
    )
    false
  end

  def available_from_date_format
    date_format = '%Y-%m-%d'
    self.available_from = available_from.strftime(date_format)
    true
  rescue StandardError
    errors.add(
      :available_from,
      'Not a valid date. Please ensure that you are sending available_from parameter with the suggested date format.'
    )
    false
  end
end

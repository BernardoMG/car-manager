require 'test_helper'

# Related to Model model
# Mostly to ensure that each validation works as expected
class ModelTest < ActiveSupport::TestCase
  test 'should save model without errors' do
    model = models(:renegade)

    assert model.save
  end

  test 'should not save model without a name' do
    model = models(:renegade)
    model.name = nil

    assert_not model.save
    assert_equal model.errors.messages[:name][0], 'Can\'t be blank.'
  end
end

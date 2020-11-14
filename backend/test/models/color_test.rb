require 'test_helper'

# Related to Color model
# Mostly to ensure that each validation works as expected
class ColorTest < ActiveSupport::TestCase
  test 'should save color without errors' do
    color = colors(:marron)

    assert color.save
  end

  test 'should not save color without a name' do
    color = colors(:marron)
    color.name = nil

    assert_not color.save
    assert_equal color.errors.messages[:name][0], 'Can\'t be blank.'
  end

  test 'should not save color without a code' do
    color = colors(:marron)
    color.code = nil

    assert_not color.save
    assert_equal color.errors.messages[:code][0], 'Can\'t be blank.'
  end
end

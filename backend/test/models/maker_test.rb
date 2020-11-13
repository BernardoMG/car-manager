require 'test_helper'

# Related to Maker model
# Mostly to ensure that each validation works as expected
class MakerTest < ActiveSupport::TestCase
  test 'should save maker without errors' do
    maker = makers(:jeep)

    assert maker.save
  end

  test 'should not save maker without a name' do
    maker = makers(:jeep)
    maker.name = nil

    assert_not maker.save
    assert_equal maker.errors.messages[:name][0], 'can\'t be blank.'
  end
end

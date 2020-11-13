require 'test_helper'

# Related to Car model
# Mostly to ensure that each validation works as expected
class CarTest < ActiveSupport::TestCase
  test 'should save car without errors' do
    car = cars(:boguinhas)

    assert car.save
  end

  test 'should not save car without the available_from field' do
    car = cars(:boguinhas)
    car.available_from = nil

    assert_not car.save
    assert_equal car.errors.messages[:available_from][0], 'can\'t be blank.'
  end

  test 'should not save car without the year field' do
    car = cars(:boguinhas)
    car.year = nil

    assert_not car.save
    assert_equal car.errors.messages[:year][0], 'can\'t be blank.'
  end

  test 'should not save car without the monthly field' do
    car = cars(:boguinhas)
    car.monthly = nil

    assert_not car.save
    assert_equal car.errors.messages[:monthly][0], 'can\'t be blank.'
  end
end

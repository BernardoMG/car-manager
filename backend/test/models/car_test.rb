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
    assert_equal(
      car.errors.messages[:available_from][0],
      'Not a valid date. Please ensure that you are sending available_from parameter with the suggested date format.'
    )
  end

  test 'should not save car with a wrong date format for the available_from field' do
    car = cars(:boguinhas)
    car.available_from = '11/31/2020'

    assert_not car.save
    assert_equal(
      car.errors.messages[:available_from][0],
      'Not a valid date. Please ensure that you are sending available_from parameter with the suggested date format.'
    )
  end

  test 'should not save car without the year field' do
    car = cars(:boguinhas)
    car.year = nil

    assert_not car.save
    assert_equal(
      car.errors.messages[:year][0],
      'Not a valid year. Please ensure that you are sending year parameter (a valid integer).'
    )
  end

  test 'should not save car with an invalid year field' do
    car = cars(:boguinhas)
    car.year = 'test'

    assert_not car.save
    assert_equal(
      car.errors.messages[:year][0],
      'Not a valid year. Please ensure that you are sending year parameter (a valid integer).'
    )
  end

  test 'should not save car without the monthly field' do
    car = cars(:boguinhas)
    car.monthly = nil

    assert_not car.save
    assert_equal(
      car.errors.messages[:monthly][0],
      'Not a valid monthly. Please ensure that you are sending monthly parameter (a valid number).'
    )
  end

  test 'should not save car with an invalid monthly field' do
    car = cars(:boguinhas)
    car.monthly = 'test'

    assert_not car.save
    assert_equal(
      car.errors.messages[:monthly][0],
      'Not a valid monthly. Please ensure that you are sending monthly parameter (a valid number).'
    )
  end

  test 'should not save car without the maker identifier' do
    car = cars(:boguinhas)
    car.maker = nil

    assert_not car.save
    assert_equal(
      car.errors.messages[:maker][0],
      'Does not exists. Please send a valid maker_id.'
    )
  end

  test 'should not save car without the model identifier' do
    car = cars(:boguinhas)
    car.model = nil

    assert_not car.save
    assert_equal(
      car.errors.messages[:model][0],
      'Does not exists. Please send a valid model_id.'
    )
  end

  test 'should not save car without the color identifier' do
    car = cars(:boguinhas)
    car.color = nil

    assert_not car.save
    assert_equal(
      car.errors.messages[:color][0],
      'Does not exists. Please, first check all the available model colors.'
    )
  end

  test 'should not save car with a color not availble for the specified model' do
    car = cars(:boguinhas)
    car.color = colors(:yellow)

    assert_not car.save
    assert_equal(
      car.errors.messages[:color][0],
      'Model does not exists on the requested color. Please, first check all the available model colors.'
    )
  end
end

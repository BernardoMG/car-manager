require 'test_helper'

module Cars
  # Related to FetchDb class
  # Mostly to ensure that everything works as expected
  class FetchDbTest < ActiveSupport::TestCase
    test 'should return all cars considering default filters' do
      start_date = future_date_to_get_no_entries(0)
      end_date = future_date_to_get_no_entries(3)

      cars = Cars::FetchDb.fetch_cars(nil, nil, start_date, end_date).as_json

      assert_equal(cars.size, 3)
      assert_equal(cars[0]['monthly'], '99.99')
      assert_equal(cars[1]['monthly'], '125.99')
    end

    test 'should return no car since db has only old entries' do
      start_date = future_date_to_get_no_entries(6)
      end_date = future_date_to_get_no_entries(9)

      cars = Cars::FetchDb.fetch_cars(nil, nil, start_date, end_date).as_json

      assert_equal(cars.size, 0)
    end

    test 'should return all cars from a specific maker' do
      start_date = future_date_to_get_no_entries(0)
      end_date = future_date_to_get_no_entries(3)
      maker = makers(:smart)

      cars = Cars::FetchDb.fetch_cars(maker.id, nil, start_date, end_date).as_json

      assert_equal(cars.size, 1)
      assert_equal(cars[0]['monthly'], '159.99')
    end

    test 'should return all cars from a specific color' do
      start_date = future_date_to_get_no_entries(0)
      end_date = future_date_to_get_no_entries(3)
      color = colors(:black)

      cars = Cars::FetchDb.fetch_cars(nil, color.id, start_date, end_date).as_json

      assert_equal(cars.size, 1)
      assert_equal(cars[0]['monthly'], '159.99')
    end

    test 'should return all cars from a specific maker and color' do
      start_date = future_date_to_get_no_entries(0)
      end_date = future_date_to_get_no_entries(3)
      maker = makers(:smart)
      color = colors(:black)

      cars = Cars::FetchDb.fetch_cars(maker.id, color.id, start_date, end_date).as_json

      assert_equal(cars.size, 1)
      assert_equal(cars[0]['monthly'], '159.99')
    end

    private

    def future_date_to_get_no_entries(number_months)
      (Date.today + number_months.months).strftime('%Y-%m-%d')
    end
  end
end

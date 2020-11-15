require 'test_helper'

module Cars
  # Related to Collector interactor
  # Mostly to ensure that everything works as expected
  class CollectorTest < ActiveSupport::TestCase
    test 'should return all cars considering default filters' do
      cars = Cars::Collector.new({}).run

      assert_equal(cars.size, 4)
      assert_equal(cars[0]['monthly'], '99.99')
      assert_equal(cars[1]['monthly'], '125.99')
    end

    test 'should return no car since db has only old entries' do
      Cars::Collector.any_instance.stubs(
        :current_date
      ).returns(future_date_to_get_no_entries(6))

      Cars::Collector.any_instance.stubs(
        :current_date
      ).returns(future_date_to_get_no_entries(9))

      cars = Cars::Collector.new({}).run

      assert_equal(cars.size, 0)
    end

    test 'should return all cars using maker filter' do
      maker = makers(:smart)
      filters = { maker_id: maker.id }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 2)
      assert_equal(cars[0]['monthly'], '139.99')
      assert_equal(cars[1]['monthly'], '159.99')
    end

    test 'should return all cars using color filter' do
      color = colors(:black)
      filters = { color_id: color.id }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 2)
      assert_equal(cars[0]['monthly'], '139.99')
      assert_equal(cars[1]['monthly'], '159.99')
    end

    test 'should return all cars using maker and color filter' do
      maker = makers(:smart)
      color = colors(:black)
      filters = { maker_id: maker.id, color_id: color.id }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 2)
      assert_equal(cars[0]['monthly'], '139.99')
      assert_equal(cars[1]['monthly'], '159.99')
    end

    test 'should return all cars using page filter' do
      filters = { page: 1 }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 4)
    end

    test 'should return no cars since page value exceeds entries' do
      filters = { page: 2 }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 0)
    end

    test 'should return all cars using sort and sort_order filters' do
      jeep = makers(:jeep)
      smart = makers(:smart)

      filters = { sort: 'year', sort_order: 'desc' }

      cars = Cars::Collector.new(filters).run

      assert_equal(cars.size, 4)
      assert_equal(cars[0]['maker_id'], jeep.id)
      assert_equal(cars[2]['maker_id'], smart.id)
    end

    private

    def future_date_to_get_no_entries(number_months)
      (Date.today + number_months.months).strftime('%Y-%m-%d')
    end
  end
end

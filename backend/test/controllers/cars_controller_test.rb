require 'test_helper'

# Related to Cars controller
# Mostly to ensure that each validation works as expected
# And produces the expected response
class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:boguinhas)
  end

  test 'should create a car' do
    post cars_url, params: { car: @car }, as: :json

    assert_response 201
  end

  test 'should not create a car due to invalid params' do
    car = @car.clone
    car.color = colors(:yellow)

    post cars_url, params: { car: car }, as: :json

    assert_response(
      422,
      {
        'errors': {
          'color': [
            'Does not exists. Please, first check all the available model colors.'
          ]
        }
      }
    )
  end

  # test "should update car" do
  #   patch car_url(@car), params: { car: {  } }, as: :json
  #   assert_response 200
  # end
end

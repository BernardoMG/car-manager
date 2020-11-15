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
    json_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert_equal(response.status, 422)
    assert_equal(
      json_response['errors']['color'][0],
      'Model does not exists on the requested color. Please, first check all the available model colors.'
    )
  end

  test 'should update car' do
    car = @car.clone
    car.year = 1994
    patch car_url(@car), params: { car: car }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(
      json_response['car']['year'],
      1994
    )
  end

  test 'should not update car because it does not exists' do
    patch car_url(4100), params: { car: @car }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal(response.status, 404)
    assert_equal(
      json_response['error'],
      'Resource not found.'
    )
  end

  test 'should not update a car resource due to missing parameters' do
    patch car_url(@car), params: { car: { } }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert_equal(response.status, 422)
    assert_equal(
      json_response['error'],
      'param is missing or the value is empty: car.'
    )
  end

  test 'should get all cars considering default filters' do
    get cars_url, as: :json
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 2)
  end
end

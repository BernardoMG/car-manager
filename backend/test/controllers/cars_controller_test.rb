require 'test_helper'

# Related to Cars controller
# Mostly to ensure that each validation works
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

  test 'should not update car because it does not exist' do
    patch car_url(4100), params: { car: @car }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal(response.status, 404)
    assert_equal(
      json_response['error'],
      'Resource not found.'
    )
  end

  test 'should not update car resource due to missing parameters' do
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
    assert_equal(json_response['cars'].size, 4)
  end

  test 'should get all cars considering maker filter' do
    maker = makers(:smart)
    filters = { maker_id: maker.id }

    get cars_url, params: filters
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 2)
  end

  test 'should get all cars considering color filter' do
    color = colors(:black)
    filters = { color_id: color.id }

    get cars_url, params: filters
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 2)
  end

  test 'should get all cars considering maker and color filter' do
    maker = makers(:smart)
    color = colors(:black)
    filters = { maker_id: maker.id, color_id: color.id }

    get cars_url, params: filters
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 2)
  end

  test 'should get all cars considering page filter' do
    filters = { page: 1 }

    get cars_url, params: filters
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 4)
  end

  test 'should get all cars considering sort and sort_order filter' do
    filters = { sort: 'available_from', sort_order: 'desc' }

    get cars_url, params: filters
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal(response.status, 200)
    assert_equal(json_response['cars'].size, 4)
    assert_equal(
      json_response['cars'][0]['available_from'],
      (Date.today + 3.months).strftime('%Y-%m-%d')
    )
    assert_equal(
      json_response['cars'][1]['available_from'],
      Date.today.strftime('%Y-%m-%d')
    )
  end
end

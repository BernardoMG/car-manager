class CarsController < ApplicationController
  # GET /cars
  # def index
  #   @cars = Car.all

  #   render json: @cars
  # end

  # POST /cars
  api :POST, '/cars', 'Endpoint to create a car.'
  formats ['json']
  param :available_from, Date, required: true, desc: 'Available from, when the car is available for booking.
                                      Use the following date format YYYY/mm/dd (e.g 2020/11/14).'
  param :year, Integer, required: true, desc: 'The year of the car.'
  param :monthly, :number, required: true, desc: 'Car subscription price. Decimal value.'
  param :model_id, :number, required: true, desc: 'Car model id. Model must exist.'
  param :maker_id, :number, required: true, desc: 'Car maker id. Maker must exist.'
  param :color_id, :number, required: true, desc: 'Car color id. Color must exist.'
  error code: 400, desc: 'Bad Request.', meta: 'Review request URL.'
  error code: 408, desc: 'Request Timeout.', meta: 'Contact support team.'
  error code: 422, desc: 'Unprocessable Entity.', meta: 'Review request parameters.'
  error code: 500, desc: 'Internal Server Error.', meta: 'Contact support team.'
  returns code: 201, desc: 'Resource Created.' do
    # missing returned params
  end
  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created, location: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # PUT /cars/:id
  # def update
  #   if @car.update(car_params)
  #     render json: @car
  #   else
  #     render json: @car.errors, status: :unprocessable_entity
  #   end
  # end
end

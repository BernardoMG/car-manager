class CarsController < ApplicationController
  # GET /cars
  # def index
  #   @cars = Car.all

  #   render json: @cars
  # end

  # POST /cars
  api :POST, '/cars', 'Endpoint to create a car.'
  formats ['json']
  param :car, Hash, required: true, desc: 'Car params' do
    param :available_from, String, required: true, desc: 'Available from, when the car is available for booking.
                                                          Use the following date format YYYY-mm-dd (e.g 2020/11/14).'
    param :year, :number, required: true, desc: 'The year of the car.'
    param :monthly, :decimal, required: true, desc: 'Car subscription price. Decimal value.'
    param :model_id, :number, required: true, desc: 'Car model id. Model must exist.'
    param :maker_id, :number, required: true, desc: 'Car maker id. Maker must exist.'
    param :color_id, :number, required: true, desc: 'Car color id. Color must exist.'
  end
  error code: 400, desc: 'Bad Request.', meta: 'Review request endpoint.'
  error code: 408, desc: 'Request Timeout.', meta: 'Contact support team.'
  error code: 422, desc: 'Unprocessable Entity.', meta: 'Review request parameters.'
  error code: 500, desc: 'Internal Server Error.', meta: 'Contact support team.'
  returns code: 201, desc: 'Resource Created.' do
    property :car, Hash, desc: 'Created Car Object' do
      property :available_from, String, required: true, desc: 'Available from, when the car is available for booking.'
      property :year, :number, required: true, desc: 'The year of the car.'
      property :monthly, :decimal, required: true, desc: 'Car subscription price.'
      property :model_id, :number, required: true, desc: 'Car model id.'
      property :maker_id, :number, required: true, desc: 'Car maker id.'
      property :color_id, :number, required: true, desc: 'Car color id.'
      property :created_at, String, required: true, desc: 'When the car object was created.'
      property :updated_at, String, required: true, desc: 'When the car object was updated.'
    end
  end
  def create
    @car = Car.new(car_params)

    if @car.save
      render json: { 'car': @car }, status: :created
    else
      render json: { 'errors': @car.errors }, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => e
    render json: { 'error': "#{e.message}." }, status: :unprocessable_entity
  rescue StandardError
    render json: { 'error': 'Something went wrong. Please contact support team.' }, status: :internal_server_error
  end

  # PUT OR PATCH /cars/:id
  api :PUT, '/cars/:id', 'Endpoint to update a specific car. You can also use PATCH method.'
  formats ['json']
  param :car, Hash, required: true, desc: 'Car params' do
    param :available_from, String, required: true, desc: 'Available from, when the car is available for booking.
                                                          Use the following date format YYYY-mm-dd (e.g 2020/11/14).'
    param :year, :number, required: true, desc: 'The year of the car.'
    param :monthly, :decimal, required: true, desc: 'Car subscription price. Decimal value.'
    param :model_id, :number, required: true, desc: 'Car model id. Model must exist.'
    param :maker_id, :number, required: true, desc: 'Car maker id. Maker must exist.'
    param :color_id, :number, required: true, desc: 'Car color id. Color must exist.'
  end
  error code: 400, desc: 'Bad Request.', meta: 'Review request endpoint.'
  error code: 404, desc: 'Not Found.', meta: 'Review car identifier.'
  error code: 408, desc: 'Request Timeout.', meta: 'Contact support team.'
  error code: 422, desc: 'Unprocessable Entity.', meta: 'Review request parameters.'
  error code: 500, desc: 'Internal Server Error.', meta: 'Contact support team.'
  returns code: 200, desc: 'Resource Updated.' do
    property :car, Hash, desc: 'Updated Car Object' do
      property :available_from, String, required: true, desc: 'Available from, when the car is available for booking.'
      property :year, :number, required: true, desc: 'The year of the car.'
      property :monthly, :decimal, required: true, desc: 'Car subscription price.'
      property :model_id, :number, required: true, desc: 'Car model id.'
      property :maker_id, :number, required: true, desc: 'Car maker id.'
      property :color_id, :number, required: true, desc: 'Car color id.'
      property :created_at, String, required: true, desc: 'When the car object was created.'
      property :updated_at, String, required: true, desc: 'When the car object was updated.'
    end
  end
  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      render json: { 'car': @car }, status: :ok
    else
      render json: { 'errors': @car.errors }, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => e
    render json: { 'error': "#{e.message}." }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    render json: { 'error': 'Resource not found.' }, status: :not_found
  rescue StandardError
    render json: { 'error': 'Something went wrong. Please contact support team.' }, status: :internal_server_error
  end

  private

  def car_params
    params.require(:car).permit(
      :available_from,
      :year,
      :monthly,
      :model_id,
      :maker_id,
      :color_id
    )
  end
end

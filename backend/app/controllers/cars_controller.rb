class CarsController < ApplicationController
  include ApipieConcern

  # GET /cars
  def index
    cars = Cars::Collector.new(search_params).run
    render json: { 'cars': cars }, status: :ok
  rescue StandardError
    render json: { 'error': 'Something went wrong. Please contact support team.' }, status: :internal_server_error
  end

  # POST /cars
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

  def search_params
    params.permit(
      :maker_id,
      :color_id,
      :page
    )
  end
end

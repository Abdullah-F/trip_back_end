class TripsController < ApplicationController
  before_action :set_trip, only: %i(show update destroy)

  def index
    trips = Trip.all
    render json: trips, status: :ok
  end

  def show
    render json: @trip, status: :ok
  end

  def create
    result = Trip::CreateTrip.call(trip_params: trip_params)
    if result.success?
      render json: result.trip, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def update
    result = Trip::Organizers::Update.call(
      event: update_params[:event],
      trip: @trip,
    )

    if result.success?
      render json: result.trip, status: :ok
    end
  end

  def destroy
    trip = @trip.destroy
    render json: trip, status: :ok
  end

  private

  def trip_params
    params.require(:trip).permit(:status)
  end

  def update_params
    params.require(:trip).permit(:event)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message, status: :not_found
  end
end

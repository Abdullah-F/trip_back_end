class Trip::CreateTrip
  include Interactor

  def call
    Trip.transaction do
      trip = Trip.create!(trip_params)
      trip.drivers << Driver.find(drivers_ids)
      context.trip = trip
    end
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(errors: e.message)
  end

  private

  def trip_params
    context.trip_params
  end

  def drivers_ids
    context.drivers_ids
  end
end

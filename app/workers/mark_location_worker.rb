class MarkLocationWorker
  include Sidekiq::Worker

  def perform(lat:, lng:, trip_id:)
    Location.create!(lat: lat, lng: lng, trip_id: trip_id)
  end
end

class Trip::Complete
  include Interactor

  def call
    return unless event == :complete
    trip.aasm(:status).fire!(event)
  end

  private

  def event
    context.event
  end

  def trip
    context.trip
  end
end

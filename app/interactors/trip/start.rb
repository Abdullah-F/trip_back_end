class Trip::Start
  include Interactor

  def call
    return unless event == :go
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

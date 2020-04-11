class Location::Create
  include Interactor

  def call
    MarkLocationWorker.perform_async(location_params)
  end

  private

  def location_params
    context.location_params.as_json.symbolize_keys
  end
end

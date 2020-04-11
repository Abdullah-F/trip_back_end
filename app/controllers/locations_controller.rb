class LocationsController < ApplicationController

  def create
    result = Location::Create.call(
      location_params: location_params
    )

    if result.success?
      head(:accepted)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def location_params
    params.require(:location).permit(:lat, :lng, :trip_id)
  end
end

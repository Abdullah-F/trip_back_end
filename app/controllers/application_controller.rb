class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    result = User::Authorize.call(headers: request.headers)
    unless result.success?
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
  end
end

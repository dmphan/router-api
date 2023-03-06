class ApplicationController < ActionController::API
  include Errors

  rescue_from APIExceptionError do |e|
    render json: { status: e.status, message: e.message }, status: e.status
  end
end

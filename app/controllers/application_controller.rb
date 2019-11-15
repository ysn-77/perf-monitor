class ApplicationController < ActionController::API
  rescue_from RailsParam::Param::InvalidParameterError, with: :show_parameter_errors

  private
  
  def show_parameter_errors(exception)
    render json:{ error: exception.message }, status: :bad_request
  end
end

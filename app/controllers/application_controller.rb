class ApplicationController < ActionController::API
  respond_to :html, :json

  private

  def authenticate_user!(_options = {})
    head :unauthorized if request.headers['Authorization'].blank?
    begin
      jwt_payload = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base).first
      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end

  def current_user
    @current_user ||= super || User.find_by_id(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end

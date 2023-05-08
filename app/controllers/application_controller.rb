class ApplicationController < ActionController::API
  include JwtToken

  before_action :authentication_user

  private

  def authentication_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JwtToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecode::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue Jwt::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
  
end

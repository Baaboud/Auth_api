class ApplicationController < ActionController::API
  include JwtToken

  before_action :authentication_user

  private

  def authentication_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
  
end

class AuthenticationController < ApplicationController
  skip_before_action :authentication_user

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = encode({user_id: @user.id})
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), userame: @user.user_name }
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end
  
end

class UsersController < ApplicationController
  skip_before_action :authentication_user, only: [:create]
  before_action :set_user, only: [:update, :show, :destory]

  def index
    @users = User.all
    render json: @users, status: 200
  end
  
  def show
    render json: @user, status: 200
  end

  def create
    @user = User.new(users_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  def update
    unless @user.update(users_params)
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  def destroy
    @user.destroy
  end

  private

  def users_params
    params.permit(:user_name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

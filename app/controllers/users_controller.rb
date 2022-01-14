class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    users = User.all

    render json: users
  end

  def show
    render json: @user.to_json(include: :tweets)
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in(user)
      render json: user, excpet: [:password_digest], status: :created, location: user
    else
      render json: { errors: user.errors }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  # # GET /users
  def index
    users = User.all

    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in(user)
      render json: user, excpet: [:password_digest], status: :created, location: user
    else
      render json: {errors: user.errors}
    end
  end


  private

  # # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

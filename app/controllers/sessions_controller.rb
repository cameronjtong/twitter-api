class SessionsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  def create
    user = User
      .find_by(username: params["session"]["username"].downcase)
      .try(:authenticate, params["session"]["password"])
    if user
      log_in(user)
      render json: user, except: [:password_digest], location: user, message: "login successful"
    else
      render json: { error: "Invalid credentials", logged_in: false }
    end
  end

  def destroy
    log_out
    render json: { message: "Logout was Successful" }
  end

  private

  def logged_in_user
    render json: { message: "Please log in." } unless logged_in?
  end
end

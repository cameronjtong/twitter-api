class SessionsController < ApplicationController
  def create
    user = User
      .find_by(username: params["session"]["username"].downcase)
      .try(:authenticate, params["session"]["password"])
    if user
      log_in(user)
      render json: user, except: [:password_digest], location: user
    else
      render json: { status: 401, logged_in: false }
    end
  end

  def destroy
    log_out
    render json: { message: "Logout was Successful" }
  end
end

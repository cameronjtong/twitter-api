class SessionsController < ApplicationController
  def create
    user = User
      .find_by(username: params["session"]["username"].downcase)
      .try(:authenticate, params["session"]["password"])
    if user
      session[:user_id] = user.id
      render json: user, only: [:username], location: user
    else
      render json: { status: 401, logged_in: false }
    end
  end
end

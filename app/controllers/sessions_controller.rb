class SessionsController < ApplicationController
  def create
    user = User
      .find_by(username: params["session"]["username"].downcase)
      .try(:authenticate, params["session"]["password"])
    if user
      # add login functionality here
      render json: user, only: [:username], status: :session_created, location: user, logged_in: true
    else
      render json: { status: 401, logged_in: false }
    end
  end
end

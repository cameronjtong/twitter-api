class SessionsController < ApplicationController
  def create
    user = User
      .find_by(username: params["session"]["username"].downcase)
      .try(:authenticate, params["session"]["password"])
    if user
      render json: {
        status: :created,
        logged_in: true,
        user: user,
        only: [:username],
      }
    else
      render json: { status: 401, logged_in: false }
    end
  end
end

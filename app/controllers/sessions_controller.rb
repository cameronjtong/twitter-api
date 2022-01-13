class SessionsController < ApplicationController
  def create
    user = User
      .find_by(username: params["session"]["username"])
      .try(:authenticate, params["session"]["password"])
    if user
      session[:user_id] = user.id
      render json: {
        status: :created,
        logged_in: true,
        user: user,
        only: [:username],
      }
    else
      render json: { status: 401 }
    end
  end

  def destroy
  end
end

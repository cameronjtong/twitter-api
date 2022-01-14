class TweetsController < ApplicationController
  before_action :logged_in_user

  def create
    tweet = current_user.tweets.build(micropost_params)
    if tweet.save
      render json: current_user.to_json.include(:tweets)
    else
      render json: { error: "invalid tweet" }
    end
  end

  def destroy
  end

  private

  def logged_in_user
    render json: { error: "Please log in." } unless current_user
  end
end

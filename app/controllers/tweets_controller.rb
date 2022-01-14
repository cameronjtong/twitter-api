class TweetsController < ApplicationController
  before_action :logged_in_user
  before_action :set_tweet, only: %i[destroy update]

  def create
    tweet = current_user.tweets.build(micropost_params)
    if tweet.save
      render json: current_user.to_json.include(:tweets)
    else
      render json: { error: "invalid tweet" }
    end
  end

  def destroy
    @tweet.destroy
    render json: { message: "tweet successfully deleted" }
  end

  def update
  end

  private

  def logged_in_user
    render json: { error: "Please log in." } unless current_user
  end

  def set_tweet
    @tweet = current_user.tweets.find_by(id: params[:id])
    render json: { error: "found no tweet" } if @tweet.nil?
  end
end

require "test_helper"

class TweetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cam)
    @tweet = tweets(:cats)
  end

  test "redirect when not logged in" do
    assert_no_difference "Tweet.count" do
      delete tweet_path(@tweet)
    end
    assert response.body =~ /error/
  end

  test "creates a valid tweet" do
    log_in_as(@user)

    assert_difference "Tweet.count" do
      post tweets_path, params: { tweet: { content: "Lorem tweet" } }
    end
  end

  test "updates tweets" do
    log_in_as(@user)

    patch tweet_path(@tweet), params: { tweet: { content: "Lorem tweet" } }
  end
end

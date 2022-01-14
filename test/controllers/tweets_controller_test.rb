require "test_helper"

class TweetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @tweet = tweets(:cats)
  end

  test "redirect when not logged in" do
    assert_no_difference "Tweet.count" do
      delete tweet_path(@tweet)
    end
    assert response.body =~ /error/
  end
end

require "test_helper"

class TweetTest < ActiveSupport::TestCase
  def setup
    @user = users(:cam)
    @tweet = Tweet.new(content: 'Lorem text', user_id: @user.id)
  end
end
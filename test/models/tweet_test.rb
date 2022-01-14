require "test_helper"

class TweetTest < ActiveSupport::TestCase
  def setup
    @user = users(:cam)
    @tweet = @user.tweets.build(content: 'Lorem text')
  end

  test 'tweets must have content' do
    @tweet.content = ""

    assert_not @tweet.valid?
  end

  test 'tweets must be less than 140 characters' do
    @tweet.content = 'a'*141

    assert_not @tweet.valid?
  end

  test 'requires a user id' do
    @tweet.user_id = nil

    assert_not @tweet.valid?
  end
end
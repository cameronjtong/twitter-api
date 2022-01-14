require "test_helper"

class UserMessagingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cam)
    @other_user = users(:nick)
  end
  test "user can create a conversation" do
    log_in_as(@user)

    post conversations_path, params: { recipient_id: @other_user.id, sender_id: @user.id }
  end
end

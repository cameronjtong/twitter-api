require "test_helper"

class UserMessagingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cam)
    @other_user = users(:nick)
    @conversation = conversations(:first)
  end

  test "user can create a conversation" do
    log_in_as(@user)

    post conversations_path, params: { recipient_id: @other_user.id, sender_id: @user.id }
    assert response.body =~ /conversation/
  end

  test "user cannot create a conversation without logging in" do
    post conversations_path, params: { recipient_id: @other_user.id, sender_id: @user.id }

    assert response.body =~ /error/
  end

  test "user can create a message" do
    log_in_as(@user)

    post conversation_messages_path(@conversation), params: {message: {body: 'Test message', user_id: @user.id}}

    assert_response :success
    assert response.body =~ /Test message/
  end

  test 'creation of message then viewing on the index page' do
     log_in_as(@user)

    post conversation_messages_path(@conversation), params: {message: {body: 'Test message', user_id: @user.id}}
    get conversation_messages_path(@conversation)

    assert_response :success
    assert response.body =~ /Test message/
  end
end

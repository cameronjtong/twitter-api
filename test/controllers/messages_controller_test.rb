require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @conversation = conversations(:first)
  end

  test "should get index" do
    get conversation_messages_path(@conversation)

    assert_response :success
    assert response.body =~ /messages/
  end

  test "should get create" do
    post conversation_messages_path(@conversation), params: {message: {body: 'Test message', user_id: @conversation.sender_id}}

    assert_response :success
  end
end

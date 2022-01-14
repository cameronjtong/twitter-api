class MessagesController < ApplicationController
  before_action :set_conversation
  def index
    messages = @conversation.messages
    render json: {messages: messages}
  end

  def create
    message = @conversation.messages.new(message_params)
   if message.save
    render json: @conversation
  else
    render json: {error: "invalid message"}
  end
end

  private

 def message_params
  params.require(:message).permit(:body, :user_id)
 end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end

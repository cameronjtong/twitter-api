class ConversationsController < ApplicationController
  before_action :set_user

  def index
    conversations = Conversation.all
    render json: conversations
  end

  def create
    conversation = if Conversation.between(params[:sender_id], params[:recipient_id]).present?
                     Conversation
                       .between(params[:sender_id], params[:recipient_id])
                       .first
                   else
                     Conversation.create!(conversation_params)
                   end
    render json: conversation
  end

  private

  def set_user
    render json: { error: "Please log in." } unless current_user
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end

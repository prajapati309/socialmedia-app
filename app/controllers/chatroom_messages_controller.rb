class ChatroomMessagesController < ApplicationController
before_action :set_chatroom
 
def create
	chatroom_message = @chatroom.chatroom_messages.new(chatroom_message_params)
	chatroom_message.user = current_user
	chatroom_message.save
	#redirect_to @chatroom
	MessageRelayJob.perform_later(chatroom_message)
end
private 
def set_chatroom
	@chatroom = Chatroom.find(params[:chatroom_id])
end
def chatroom_message_params
	params.require(:chatroom_message).permit(:body)
end
end

class MessageRelayJob < ApplicationJob	
  queue_as :default

  def perform(chatroom_message)
  	ActionCable.server.broadcast "chatrooms#{chatroom_message.chatroom.id}",
  	Chatroom_message: ChatroomMessagesController.render(partial: 'chatroom_messages/chatroom_message', locals: { message: message}),
  	chatroom_id: chatroom_message.chatroom.id 
  end
end

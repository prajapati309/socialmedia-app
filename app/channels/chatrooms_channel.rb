class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
  	current_user.chatrooms.each do |chatroom|
  	stream_from "chatroom:#{chatroom.id}"
  end
    # stream_from "some_channel"
  end

  def unsubscribed
  	stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(chatroom_message)
    ActionCable.server.broadcast("chatroom:#{chatroom.id}", chatroom_message)
  end
end

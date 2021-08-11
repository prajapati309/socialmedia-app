class ChatroomUsersController < ApplicationController
before_action :set_chatroom

def create
	@chatroom = Chatroom.find_by_id(params[:chatroom_id])
@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
@chatroom_user.save
redirect_to @chatroom	
end
def destroy
	
	@chat = Chatroom.find_by_id(params[:chatroom_id])
	@chatroom_user = @chat.chatroom_users.where(user_id: current_user.id).destroy_all
	redirect_to chatrooms_path
end

private 
def set_chatroom

	@chatroom = Chatroom.find_by_id(params[:id])
end
end

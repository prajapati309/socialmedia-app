class ConversationsController < ApplicationController
before_action :set_conversation, except: [:index]
before_action :check_participating!, except: [:index]
before_action :find_conversation! , only: [:create]
def index
        @conversations = Conversation.participating(current_user).order('updated_at DESC')

end
def show

  @message = Message.new
end

def new
  redirect_to conversation_path(@conversation) and return if @conversation
  @message = current_user.messages.build
end


private 

def set_conversation
  @conversation = Conversation.find_by(id: params[:id])
end

def check_participating!
  redirect_to root_path unless @conversation && @conversation.participates?(current_user)
end	
def find_conversation!
  if params[:receiver_id]
    @receiver = User.find_by(id: params[:receiver_id])
    redirect_to(root_path) and return unless @receiver
    @conversation = Conversation.between(current_user.id, @receiver.id)[0]
  else
    @conversation = Conversation.find_by(id: params[:conversation_id])
    redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
  end
end

end

class FriendshipsController < ApplicationController
before_action :def_user, only: [:create, :accept, :deny, :destroy]


def index
	@users = User.all

@user = current_user
@friends = @user.friends.paginate :page => params[:page]
@pending_friends = @user.pending_friends.paginate :page => params[:page]
@requested_friends = @user.requested_friends.paginate :page => params[:page]
end


def show
@friend = User.find(params[:id])
end

def create
if already_sent_request?
	flash[:notice] = "You already sent the friend request "
else	
Friendship.request(@user1, @friend)
flash[:notice] = "Friend request has been sent to #{@friend.first_name}."
 respond_to do |format|

      format.html  # index.html.erb
      format.js  {  }
    end
end
end

def already_sent_request?
		Friendship.where(user_id: current_user.id, 	friend_id: @friend.id).exists?
	end


def accept
Friendship.accept(@user1, @friend)

flash[:notice] = "Friend request from #{@friend.first_name} has been accepted."
# redirect_to friends_path
	  respond_to do |format|
	  	#format.html
        # index.html.erb
      format.js 
  end
 
end


def deny
	
Friendship.breakup(@user1, @friend)
flash[:notice] = "Friend request from #{@friend.first_name} has been declined."
respond_to do |format|

      format.html  # index.html.erb
      format.js  {  }
    end
 
     
#redirect_to friends_path
end


def destroy

Friendship.breakup(@user1, @friend)
flash[:notice] = "#{@friend.first_name} has been successfully removed from your friends list."
#redirect_to friends_path

respond_to do |format|

      format.html  # index.html.erb
      format.js  {  }
    end

end


private
def def_user

@user1 = current_user
@friend = User.find(params[:id])
end







=begin	def create
	  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  if @friendship.save
	    flash[:notice] = "Added friend."
	    redirect_to root_url
	  else
	    flash[:notice] = "Unable to add friend."
	    redirect_to root_url
	  end
	end
	def destroy
	
	  @friendship = current_user.friendships.find(params[:id])
	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to current_user
	end
	def show 
		
	end
=end	
end

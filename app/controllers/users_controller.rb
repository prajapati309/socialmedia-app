class UsersController < ApplicationController

def show
    @user = User.find(params[:id])
end
def index
	
	@users = User.all
end
def destroy     
	user = User.find(params[:id]).destroy
	redirect_to users_path
end
def activate
	user = User.find(params[:id])
	if current_user.admin?
    user.activate_account!

    flash[:notice] = "account is activated of #{user.first_name}"

    redirect_to users_path 
 	else
    redirect_to :back
  	end
end


def deactivate
	user = User.find(params[:id])
	if current_user.admin?
    user.deactivate_account!

    flash[:notice] = "account is deactivated of #{user.first_name}"

    redirect_to users_path 
 	else
    redirect_to :back
  	end
end
end

def add_friend
    
end
  
def remove_friend
    
end
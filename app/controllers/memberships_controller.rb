class MembershipsController < ApplicationController
 def create
    debugger
    @membership = current_user.memberships.build(membership_params)
    if @membership.save
      flash[:notice] = "You have joined this group."
      redirect_to :back
    else
      flash[:error] = "Unable to join."
      redirect_to :back
    end
  end
  def index
    
  end
   def new
        @room = Room.find params[:id]
        @membership = Membership.new({room: room})
      end

  def show
    
  end




  

=begin def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    flash[:notice] = "Removed membership."
        redirect_to rooms_path
  end
=end
private 
 def membership_params
        params.require(:membership).permit(room_id: @room.id )
    end
end

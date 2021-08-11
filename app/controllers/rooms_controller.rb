class RoomsController < ApplicationController
  before_action :load_entities
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end
  def show
  @room_message = RoomMessage.new room: @room
  @room_messages = @room.room_messages.includes(:user)
  #order("created_at Desc")
  end
  def join
    if already_joined?
      flash[:notice] = "You already in this group"
    else 
    @room = Room.find(params[:id])
    @room.memberships.create(user_id: current_user.id , room_id: @room.id)
    redirect_to rooms_path
  end
  end
  def already_joined?
    Membership.where(user_id: current_user.id, room_id:
      params[:id]).exists?
  end

   def leave
    @room = Room.find(params[:id])
    @room.memberships.find_by(user_id: current_user.id)
    @m.destroy
    respond_to do |format|
      if @m.destroy
        format.html { redirect_to(rooms_path, :notice => 'You leave the group.') }
       
      else
        format.html { redirect_to(@room, :notice => 'leave error.') }

      end
    end
  end

  
 

  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name , :user_id)
  end
end

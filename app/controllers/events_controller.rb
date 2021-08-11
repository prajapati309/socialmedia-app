class EventsController < ApplicationController
	
	def index
		@events = Event.all
	end
	def create
		puts "create action in event"
		@event = current_user.events.build(event_params)
		@event.save 
		redirect_to events_path
	end
	def destroy 
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to events_path(@event)
	end
	def new 
		@event = Event.new
	end
	private 
	def event_params 
		params.require(:event).permit(:body, :start_date,:end_date)
		
	end
end

class EventsController < ApplicationController
  def index
    @events = Event.order("start_time ASC").page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @venues = Venue.order("name ASC")
  end

  def create
    @venue = Venue.find(params[:event][:venue_id])
    @event = @venue.events.new(event_params)
    if @event.save
      flash[:notice] = "Event created!"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :description, :start_time, :end_time
      )
  end

end

class EventsController < ApplicationController
  def index
    @events = Event.order("start_time ASC").page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @call = @event.calls.new
    @positions = Position.all
    @position = @event.positions.new
    @users = User.order("last_name ASC")
  end

  def new
    @event = Event.new
    @venue = Venue.new
    @venues = Venue.order("name ASC")
  end

  def create
    @venue = Venue.find(params[:event][:venue_id])
    @event = @venue.events.new(event_params)
    @venues = Venue.order("name ASC")
    @venues_array = @venues.map { |venue| [venue.name, venue.id] }
    if @event.save
      flash[:notice] = "Event created!"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @venues = Venue.order("name ASC")
    @positions = Position.all
  end

  def update
    @event = Event.find(params[:id])
    @venues = Venue.order("name ASC")
    if @event.update(event_params)
      flash[:notice] = "Event updated!"
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event deleted!"
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :description, :start_time, :end_time, :position
      )
  end

  def call_params
    params.require(:call).permit(:event, :user)
  end
end

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:index, :show]

  def index
    @events = Event.order("start_time ASC").page(params[:page])
    pending_offers = []
    # move this logic to model?
    current_user.offers.each { |o| pending_offers << o.event.calls.where(user: nil) }
    @pending_offers = pending_offers.flatten.uniq { |c| c.event_id }
  end

  def show
    @event = Event.find(params[:id])
    @calls = @event.calls
    @call = @event.calls.new
    @offer = @call.offers.new
    @offers = @event.offers.order("created_at ASC")
    @user_offers = @event.offers.where(user: current_user)
    @position = @event.positions.new
    @positions = Position.all
    # eventually limit the number of users that show,
    # possibly by company affiliation? or paginate, use js/infinite scroll here
    @users = User.order("last_name ASC")
    @availability = @offer.availabilities.new
    @google_maps_url = %Q{
      https://www.google.com/maps/embed/v1/place?key=
      #{ENV["GOOGLE_MAPS_API_KEY"]}&q=#{@event.venue.parse_for_google_maps}
    }
  end

  def new
    @event = Event.new
    @venue = Venue.new
    # eventually limit the number of venues that show. paginate/infinite scroll?
    @venues = Venue.order("name ASC")
  end

  def create
    @venue = Venue.find(params[:event][:venue_id])
    @event = @venue.events.new(event_params)
    @venues = Venue.order("name ASC")
    respond_to do |format|
      if @event.save
        @event.add_to_calendar(@event, current_user)
        format.html { redirect_to event_path(@event), notice: "Event created!"}
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
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

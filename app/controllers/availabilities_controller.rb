class AvailabilitiesController < ApplicationController

  # def index
  #   @availabilities = Availability.all
  # end

  def new
    @availability = Availability.new
  end

  def create
    @offer = current_user.offers.find_by(event_id: params[:event_id])
    @event = @offer.event
    @availability = @offer.availabilities.new(availability_params)
    if @availability.save
      flash[:notice] = "Availability saved!"
      redirect_to event_path(@event)
    else
      redirect_to :back
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:call_id, :available)
  end
end

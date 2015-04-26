class AvailabilitiesController < ApplicationController
  def new
    @availability = Availability.new
  end

  def create
    binding.pry
    @offer = current_user.offers.find_by(event_id: params[:event_id])
    @event = @offer.event
    @availabilities = availability_params[:available].each_index { |i| @offer.availabilities.create(available: availability_params[:available][i], call_id: availability_params[:call_id][i]) }
    if !@availabilities.any? { |a| "true" }
      redirect_to :back
    else
      flash[:notice] = "Availability saved!"
      redirect_to event_path(@event)
    end
  end

  private

  def availability_params
    params.require(:availability).permit(available: [], call_id: [])
  end
end

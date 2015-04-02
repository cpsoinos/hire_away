class EventsController < ApplicationController
  def index
    @events = Event.order("start_time ASC").page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:restaurant).permit(
      :name, :description, :start_time, :end_time
      )
  end

end

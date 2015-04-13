class CallsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @call = @event.calls.new(call_params)
    if @call.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Call added!"
          redirect_to event_path(@event)
        end
        format.js do
          render :create
        end
      end
    else
      redirect_to :back
    end
  end

  private

  def call_params
    params.require(:call).permit(:event, :position_id)
  end
end

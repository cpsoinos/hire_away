class CallsController < ApplicationController
  before_action :authorize_admin!

  def index
    @calls = Call.all
  end

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

  def update
    @event = Event.find(params[:event_id])
    @call = Call.find(params[:id])
    @call.update(call_params)
    if @call.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Call updated!"
          redirect_to event_path(@event)
        end
        format.js do
          render :update
        end
      end
    else
      redirect :back
    end
  end

  private

  def call_params
    params.require(:call).permit(:event, :position_id, :start_time, :end_time, :user_id)
  end
end

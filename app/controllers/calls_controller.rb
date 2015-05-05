class CallsController < ApplicationController
  before_action :authorize_admin!

  def create
    @event = Event.find(params[:event_id])
    @call = @event.calls.new(call_params)
    @users = User.order("last_name ASC")
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
      # how to show error if format is js (ajax)?
      redirect_to :back
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @call = Call.find(params[:id])
    @call.update(call_params)
    if @call.save
      @offer = @call.user.offers.find_by(event_id: params[:event_id])
      if @offer
        @offer.availabilities.find_or_create_by(available: true, call: @call)
      else
        # creates an availability by default if admin manually assigns a user
        # to a call without sending an offer first
        @call.availabilities.find_or_create_by(available: true)
      end
      respond_to do |format|
        format.html do
          flash[:notice] = "Call updated!"
          redirect_to event_path(@event)
        end
        format.js do
          render :update
        end
        format.json do
          @call
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

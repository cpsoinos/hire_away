class CallsController < ApplicationController

  def new
    @offer = Offer.new
  end

  def create
    @event = Event.find(params[:id])
    @call = Call.find(params[:call_id])
    @offer = @call.offer.new(params[:user_id])
    if @offer.save
      flash[:notice] = "Offers sent!"
      redirect_to :show
    else
      render :show
    end
  end

end

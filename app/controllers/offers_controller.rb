class OffersController < ApplicationController

  def new
    @offer = Offer.new
  end

  def create
    @event = Event.find(params[:event_id])
    vendors = params[:offer][:user_id]
    offer_to(vendors)
    redirect_to event_path(@event)
    # if @offer.save
    #   flash[:notice] = "Offers sent!"
    #   redirect_to :show
    # else
    #   render :show
    # end
  end

  private

  def offer_params
    params.require(:offer).permit(:user_id)
  end

  def offer_to(vendors)
    vendors.each do |vendor|
      @offer = Offer.create(user: User.find(vendor), event: Event.find(params[:event_id]))
    end
  end
end

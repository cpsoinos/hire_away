class OffersController < ApplicationController

  def new
    @offer = Offer.new
  end

  def create
    @event = Event.find(params[:event_id])
    @offers = []
    offer_params[:user_id].each do |id|
      vendor = User.find(id)
      @offer = vendor.offers.new(event: @event)
      @offers << @offer
    end
    if @offers.any? { |offer| !offer.valid? }
      redirect_to :back
    else
      @offers.each do |offer|
        offer.save
        OfferWorker.perform_async(offer.id)
      end
      flash[:notice] = "Offers sent!"
      redirect_to event_path(@event)
    end
  end

  private

  def offer_params
    params.require(:offer).permit(user_id: [])
  end
end

class OfferWorker
  include Sidekiq::Worker

  def perform(offer_id)
    offer = Offer.find(offer_id)
    binding.pry
    OfferMailer.delay.new_offer(offer)
  end
end

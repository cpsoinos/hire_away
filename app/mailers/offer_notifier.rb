class OfferNotifier < ApplicationMailer
  def new_offer(offer)
    @offer = offer
    @event = offer.event
    @calls = offer.event.calls

    mail(
      to: offer.user.email,
      subject: "Overhire call for #{@vent.name}"
    )
  end
end

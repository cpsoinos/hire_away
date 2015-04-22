class OfferMailer < ApplicationMailer
  default from: "coreypsoinos@gmail.com"

  def offer_email(offer)
    @offer = offer
    @user = offer.user
    @event = offer.event
    @calls = @event.calls.where(user: nil)
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "New calls available")
  end
end

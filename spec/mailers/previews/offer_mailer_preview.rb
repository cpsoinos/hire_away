class OfferMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    OfferMailer.new_offer(Offer.first)
  end
end

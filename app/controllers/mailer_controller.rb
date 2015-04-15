class MailerController < ApplicationController

  def offer_email()
    @user = User.last
    @offer = Offer.last
    @user = @offer.user
    @event = @offer.event
    @calls = @offer.event.calls
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    render :file => 'offer_mailer/offer_email.html.erb', :layout => 'mailer'
  end

end

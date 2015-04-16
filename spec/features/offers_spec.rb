require 'rails_helper'

feature "admin sends out calls for an event", %Q{
  As an admin
  I want to send out calls
  So that I can hire for an event
} do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  # let!(:offer) { FactoryGirl.create(:offer) }
  before :each do
    sign_in admin
  end

  scenario "admin selects vendors for calls" do
    visit event_path(event)
    select(user.full_name, from: "offer_user_id")
    click_button "Create Offer"
    # save_and_open_page
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end

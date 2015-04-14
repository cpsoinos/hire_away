require 'rails_helper'

feature "admin sends out calls for an event", %Q{
  As an admin
  I want to send out calls
  So that I can hire for an event
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }
  before :each do
    sign_in admin
  end

  scenario "admin selects vendors for calls" do
    visit event_path(event)
    select(user.full_name, from: "offer_user_id")
    click_button "Create Offer"

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end

require 'rails_helper'

feature "admin sends out calls for an event", %Q{
  As an admin
  I want to send out calls
  So that I can hire for an event
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:position) { FactoryGirl.create(:position) }
  before :each do
    sign_in admin
  end

  scenario "admin adds a call to an event" do
    visit event_path(event)
    select(position.name, from: "call_position_id")
    fill_in("call_start_time", with: DateTime.now)
    fill_in("call_end_time", with: DateTime.now)
    click_button "Create Call"

    expect(page).to have_content(position.name)
  end
end

require 'rails_helper'

feature "admin adds positions to an event", %Q{
  As an admin
  I want to add positions to an event
  So that I can fill them
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:position) { FactoryGirl.create(:position) }
  before :each do
    sign_in admin
  end

  scenario "admin adds position to event" do
    visit event_path(event)
    click_button("Add position")

    select position.name, from: "Position"
    # not finished
  end
end

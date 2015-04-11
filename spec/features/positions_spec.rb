require 'rails_helper'

feature "admin hires for an event", %Q{
  As an admin
  I want to manage positions
  So I can add them to events
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:position) { FactoryGirl.create(:position) }
  before :each do
    sign_in admin
  end

  scenario "admin wants to create a new position" do
    visit event_path(event)

    expect(page).to have_button("New Position")
  end

  scenario "admin successfully creates a new position" do
    visit event_path(event)
    click_button("New Position")

    fill_in "Name", with: "Load-in"
    fill_in "Pay rate cents", with: "1750"
    click_button("Create Position")

    expect(page).to have_content("Position created!")
  end

  scenario "admin unsuccessfully creates a new position" do
    visit new_position_path
    fill_in "Name", with: ""
    click_button("Create Position")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "admin successfully edits a position" do
    visit edit_position_path(position)
    fill_in "Name", with: "new name"
    click_button("Update Position")

    expect(page).to have_content("Position updated!")
  end

  scenario "admin unsuccessfully edits a position" do
    visit edit_position_path(position)
    fill_in "Name", with: ""
    click_button("Update Position")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "admin deletes a position" do
    visit edit_position_path(position)
    click_button("Delete Position")

    expect(page).to have_content("Position deleted!")
  end
end

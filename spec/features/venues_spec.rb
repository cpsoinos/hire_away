require 'rails_helper'

feature "admin views venues", %Q{
  As an admin
  I want to view a list of venues
  So I can see where the company has worked
} do

  let!(:venue) { FactoryGirl.create(:venue) }
  let!(:admin) { FactoryGirl.create(:admin) }
  before :each do
    sign_in admin
  end

  scenario "admin views venues index page" do
    visit venues_path

    expect(page).to have_link(venue.name)
    expect(page).to have_button("New venue")
    expect(page).to have_button("Edit")
    expect(page).to have_button("Delete")
  end

  scenario "admin adds a new event" do
    visit venues_path
    click_button("New venue")

    expect(page).to have_content("New Venue")
  end

  scenario "admin provides valid information" do
    visit new_venue_path
    fill_in "Name", with: "Hack/Reduce"
    fill_in "Street address", with: "275 Third St."
    fill_in "City", with: "Cambridge"
    select "Massachusetts", from: "venue_state"
    click_button("Create Venue")

    expect(page).to have_content("Venue created!")
  end

  scenario "admin provides invalid information" do
    visit new_venue_path
    click_button("Create Venue")

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("City can't be blank")
  end

  scenario "admin views venue details page" do
    visit venues_path
    click_link(venue.name)

    expect(page).to have_content(venue.name)
    expect(page).to have_content(venue.street_address)
    expect(page).to have_content(venue.city)
    expect(page).to have_content(venue.state)
    expect(page).to have_content(venue.zip_code)
    expect(page).to have_content(venue.contact_name)
    expect(page).to have_content(venue.contact_phone)
    expect(page).to have_content(venue.contact_email)
    expect(page).to have_button("Edit venue")
  end

  scenario "admin edits a venue" do
    visit venue_path(venue)
    click_button("Edit venue")

    expect(page).to have_content("Edit venue details below")
  end

  scenario "admin provides new valid info" do
    visit edit_venue_path(venue)
    fill_in "Name", with: "New Venue Name"
    click_button("Update Venue")

    expect(page).to have_content("Venue updated!")
  end

  scenario "admin provides new invalid info" do
    visit edit_venue_path(venue)
    fill_in "Name", with: ""
    click_button("Update Venue")

    expect(page).to have_content("Name can't be blank")
  end


  scenario "admin deletes a venue from index" do
    visit venues_path
    click_button("Delete")

    expect(page).to have_content("Venue deleted!")
  end

  scenario "admin deletes a venue from details page" do
    visit venue_path(venue)
    click_button("Delete venue")

    expect(page).to have_content("Venue deleted!")
  end

end

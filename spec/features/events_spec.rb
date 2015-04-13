require 'rails_helper'

feature "guest views list of events", %Q{
  As a guest
  I want to view a list of events
  So I can see what the company is doing
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  scenario "guest goes to home page" do
    visit root_path

    expect(page).to have_content("Events")
    expect(page).to have_content(event.name)
    expect(page).to have_content(event.venue.name)
    expect(page).to have_content(event.venue.city)
    expect(page).to have_content(event.venue.state)
  end

  scenario "guest views event details page" do
    visit root_path
    click_link(event.name)

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.description)
  end
end

feature "admin views list of events", %Q{
  As an admin
  I want to view a list of events
  So I can see what the company is doing
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  before :each do
    sign_in admin
  end

  scenario "admin views event details page" do
    visit event_path(event)

    expect(page).to have_button("Edit event")
    expect(page).to have_button("Delete event")
  end

  scenario "admin wants to add a new event" do
    visit events_path

    expect(page).to have_button("Add new event")
  end

  scenario "admin goes to add a new event" do
    visit events_path
    click_button("Add new event")

    expect(page).to have_button("Create a new venue")
    expect(page).to have_content("or select an existing one in the form below")
  end

  scenario "admin provides valid details to add a new event" do
    visit new_event_path
    fill_in "event_name", with: event.name
    fill_in "event_description", with: event.description
    select event.venue.name, from: "event_venue_id"
    click_button("Create Event")

    expect(page).to have_content("Event created!")
  end

  scenario "admin provides invalid details to add a new event" do
    visit new_event_path
    fill_in "event_name", with: ""
    fill_in "event_description", with: ""
    click_button("Create Event")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "admin creates a new venue before creating a new event" do
    visit new_event_path
    click_button "Create a new venue"
    fill_in "venue_name", with: "GitHub"
    fill_in "Street address", with: "teh intarwebs"
    fill_in "City", with: "Not a real place, duh"
    fill_in "Zip code", with: "01345"
    click_button("Create Venue")

    expect(page).to have_content("Venue created!")
  end

  scenario "admin creates a new event after creating a new venue" do
    visit new_event_path
    click_button "Create a new venue"
    fill_in "venue_name", with: "GitHub"
    fill_in "Street address", with: "teh intarwebs"
    fill_in "City", with: "Not a real place, duh"
    fill_in "Zip code", with: "01345"
    click_button("Create Venue")

    # rspec is not recognizing that this request is sent by JS,
    # so explicitly visiting the page again
    visit new_event_path
    select "GitHub", from: "event_venue_id"
    fill_in "event_name", with: "Pull Request"
    click_button("Create Event")

    expect(page).to have_content("Event created!")
  end

  scenario "admin unsuccessfully creates a new venue before creating a new event" do
    visit new_event_path
    click_button "Create a new venue"
    fill_in "venue_name", with: ""
    click_button("Create Venue")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "admin wants to edit an existing event" do
    visit edit_event_path(event)

    expect(page).to have_content("Edit event details below")
  end

  scenario "admin provides new valid input" do
    visit edit_event_path(event)
    fill_in "Name", with: "Some New Name"
    fill_in "Description", with: "We're actually changing the entire event."
    click_button("Update Event")

    expect(page).to have_content("Event updated!")
  end

  scenario "admin provides new invalid input" do
    visit edit_event_path(event)
    fill_in "Name", with: ""
    click_button("Update Event")

    expect(page).to have_content("Name can't be blank")
  end

  scenario "admin wants to delete an event from details page" do
    visit event_path(event)

    expect(page).to have_button("Delete event")
  end

  scenario "admin deletes an event from details page" do
    visit event_path(event)
    click_button("Delete event")

    expect(page).to have_content("Event deleted!")
  end

  scenario "admin deletes an event from edit event page" do
    visit edit_event_path(event)
    click_button("Delete event")

    expect(page).to have_content("Event deleted")
  end
end

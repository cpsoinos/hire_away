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

feature "admin views events" do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  before :each do
    sign_in admin
  end

  scenario "admin views event details page" do
    visit event_path(event)

    expect(page).to have_content("Edit event")
    expect(page).to have_content("Delete event")
  end

  scenario "admin wants to add a new event" do
    visit events_path

    expect(page).to have_button("New Event")
  end

  scenario "admin goes to add a new event" do
    visit events_path
    click_button("New Event")

    expect(page).to have_content("Enter event details below:")
  end

  scenario "admin provides valid details to add a new event" do
    visit new_event_path
    fill_in "Name", with: event.name
    fill_in "Description", with: event.description
    fill_in "Start time", with: event.start_time
    fill_in "End time", with: event.end_time
    select event.venue, from: "Venue"
    click_button("Create Event")

    expect(page).to have_content("Event created!")
  end
end

require 'rails_helper'

feature "guest views list of events", %Q{
  As a guest
  I want to view a list of events
  So I can see what the company is doing
} do

  let!(:event) { FactoryGirl.create(:event) }

  scenario "guest goes to home page" do
    visit events_path

    expect(page).to have_content("You need to sign in or sign up before continuing")
    expect(page).not_to have_content(event.name)
  end

  scenario "guest cannot view event details page" do
    visit events_path

    expect(page).not_to have_content(event.name)
  end
end

feature "user views list of events", %Q{
  As a user
  I want to see a list of events I'm on
  So I can schedule accordingly
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:call) { FactoryGirl.create(:call) }
  let!(:position) { FactoryGirl.create(:position) }
  let!(:offer) { FactoryGirl.create(:offer) }

  scenario "user goes to home page" do
    sign_in user
    visit events_path

    expect(page).to have_content("Events")
    expect(page).not_to have_content(event.name)
  end

  scenario "user goes to home page after being assigned to an event" do
    sign_in call.user
    visit events_path

    expect(page).to have_link(call.event.name)
    expect(page).to have_content(call.event.venue.name)
  end

  scenario "user views event details page for an event they're on" do
    call2 = Call.create(event: event, position: position, start_time: DateTime.now, end_time: DateTime.now, user: user)
    sign_in user
    visit event_path(event)

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.venue.name)
    expect(page).to have_content(event.venue.city)
    expect(page).to have_content(event.venue.state)
    expect(page).to have_content(position.name)
    expect(page).to have_content(call2.start_time.strftime("%B %e, %Y %l:%M%P"))
    expect(page).to have_content(call2.end_time.strftime("%B %e, %Y %l:%M%P"))
    expect(page).to have_content("Confirmed")
  end

  scenario "user views event details page for a call they've been offered" do
    sign_in user
    offer.update(user: user)
    call2 = offer.event.calls.create(
      position: position,
      start_time: DateTime.now,
      end_time: DateTime.now
    )

    visit event_path(offer.event)


    expect(page).to have_content(offer.event.name)
    expect(page).to have_content(offer.event.venue.name)
    expect(page).to have_content(offer.event.venue.city)
    expect(page).to have_content(offer.event.venue.state)
    expect(page).to have_content(call2.position.name)
    expect(page).to have_content(call2.start_time.strftime("%B %e, %Y %l:%M%P"))
    expect(page).to have_content(call2.end_time.strftime("%B %e, %Y %l:%M%P"))
    expect(page).to have_unchecked_field("availability_available_true")
    expect(page).not_to have_content("Confirmed")
  end

  scenario "user sends availability for an offer" do
    sign_in user
    offer.update(user: user)
    offer.event.calls.create(
      position: position,
      start_time: DateTime.now,
      end_time: DateTime.now
    )

    visit event_path(offer.event)
    check("availability_available_true")
    click_button("Create Availability")

    expect(page).to have_content("Availability saved!")
    expect(page).not_to have_checked_field("availability_available_true")
    expect(page).not_to have_content("Confirmed")
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
    fill_in("event_start_time", with: DateTime.now)
    fill_in("event_end_time", with: DateTime.now)
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

  scenario "admin creates a new event after creating a new venue", focus: true, js: true do
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
    fill_in("event_start_time", with: DateTime.now)
    fill_in("event_end_time", with: DateTime.now)
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

require 'rails_helper'

feature "admin adds positions to an event", %Q{
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

  scenario "admin adds position to event" do
    visit event_path(event)
    # coffeescript, not needed for test:
    # click_button("Add position")
    select position.name, from: "call_position_id"
    fill_in("call_start_time", with: DateTime.now)
    fill_in("call_end_time", with: DateTime.now)
    click_button("Create Call")

    expect(page).to have_content(position.name)
  end

  scenario "admin successfully creates a new position" do
    visit event_path(event)
    # coffeescript, not needed for test:
    # click_button("Add a new position")
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

feature "admin sends out calls to users", %Q{
  As an admin
  I want to send out calls
  So I can hire users
} do

  let!(:event) { FactoryGirl.create(:event) }
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:position) { FactoryGirl.create(:position) }
  let!(:user) { FactoryGirl.create(:user) }
  before :each do
    sign_in admin
  end

  scenario "admin wants to select a user for a position" do
    visit event_path(event)

    expect(page).to have_content(position.name)
    expect(page).to have_content(user.full_name)
  end

end

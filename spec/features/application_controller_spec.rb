require 'rails_helper'

feature "guest gets redirected", %Q{
  As a guest
  I shouldn't be able to see most pages
  Because I'm not authorized
} do

  let!(:event) { FactoryGirl.create(:event) }

  scenario "guest tries to view index" do
    visit events_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  scenario "guest tries to view details" do
    visit events_path(event)

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end

# feature "user gets 404", %Q{
#   As a user
#   I shouldn't be able to see certain pages
#   Because I'm not authorized
# } do
#
#   let!(:event) { FactoryGirl.create(:event) }
#   let!(:user) { FactoryGirl.create(:user) }
#   before :each do
#     sign_in user
#   end
#
#   scenario "user tries to view new event page" do
#     visit new_event_path
#
#     expect(response.status).to eq(404)
#   end
#
#   scenario "guest tries to view venues index" do
#     visit venues_path
#
#     expect(response.status).to eq(404)
#   end
#
#   scenario "guest tries to view new venue page" do
#     visit new_venue_path
#
#     expect(response.status).to eq(404)
#   end
# end

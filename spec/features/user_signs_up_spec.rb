require "rails_helper"

feature "user registers", %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don"t specify the required information, I am presented with
  #   an error message
  let!(:user) { FactoryGirl.create(:user) }

  scenario "provide valid registration information" do
    visit new_user_registration_path

    fill_in "Email", with: "john.smith@fake.com"
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_street_address", with: user.street_address
    fill_in "user_street_address_2", with: user.street_address_2
    fill_in "user_city", with: user.city
    select "Massachusetts", from: "user_state"
    fill_in "user_zip_code", with: user.zip_code
    fill_in "user_phone", with: user.phone

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "provide invalid registration information" do
    visit new_user_registration_path

    click_button "Sign up"
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end
end

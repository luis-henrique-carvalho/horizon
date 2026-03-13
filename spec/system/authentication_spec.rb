require "rails_helper"

RSpec.describe "Authentication", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "allows a user to sign up" do
    visit new_user_registration_path
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "password123"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_link("Sair")
  end

  it "allows a user to sign in" do
    User.create!(email: "user@example.com", password: "password123")

    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password123"
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_link("Sair")
  end
end

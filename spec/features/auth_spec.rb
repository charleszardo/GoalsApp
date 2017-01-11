require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "valid_username"
      fill_in "Password", with: "valid_password"
      click_on "submit"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "valid_username"
    end

    scenario "redirects to users show page after sign up" do
      expect(page).to have_content "My Goals"
    end

  end

end

feature "logging in" do
  before(:each) do
    visit new_user_url
    fill_in "Username", with: "valid_username"
    fill_in "Password", with: "valid_password"
    click_on "submit"
    click_on "Logout"
  end

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in "Username", with: "valid_username"
    fill_in "Password", with: "valid_password"
    click_on "submit"
    expect(page).to have_content "valid_username"
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit goals_url
    expect(page).to have_content "Sign Up"
    expect(page).to have_content "Sign In"
    expect(page).to_not have_content "Welcome"
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in "Username", with: "valid_username"
    fill_in "Password", with: "valid_password"
    click_on "submit"
    click_on "Logout"
    expect(page).to_not have_content "valid_username"
  end

end

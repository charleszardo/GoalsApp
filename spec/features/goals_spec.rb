require 'spec_helper'
require 'rails_helper'

feature "adding goals" do

  scenario "user is signed in" do
    visit new_user_url
    fill_in "Username", with: "valid_username"
    fill_in "Password", with: "valid_password"
    click_on "submit"
    click_on "Add Goal"
    expect(page).to have_content "Add Goal"
    fill_in "Title", with: "my title"
    fill_in "Body", with: "my body"
    click_on "submit"
    expect(page).to have_content "my title"
  end

  scenario "user is not signed in" do
    visit new_goal_url
    expect(page).to have_content "All Users"
  end
end

feature "private goals" do
  before(:each) do
    visit new_user_url
    fill_in "Username", with: "user1"
    fill_in "Password", with: "password"
    click_on "submit"
    click_on "Add Goal"
    fill_in "Title", with: "my title"
    fill_in "Body", with: "my body"
    choose "Private"
    click_on "submit"
  end

  scenario "goal creator is signed in" do
    expect(page).to have_content "my title"
  end

  scenario "other user is signed in" do
    click_on "Logout"
    visit new_user_url
    fill_in "Username", with: "user2"
    fill_in "Password", with: "password"
    click_on "submit"
    visit user_url(User.find_by_username("user1"))
    expect(page).to_not have_content "my title"
  end
end

feature "public goals" do
  before(:each) do
    visit new_user_url
    fill_in "Username", with: "user1"
    fill_in "Password", with: "password"
    click_on "submit"
    click_on "Add Goal"
    fill_in "Title", with: "my title"
    fill_in "Body", with: "my body"
    choose "Public"
    click_on "submit"
  end

  scenario "all users" do
    expect(page).to have_content "my title"
    click_on "Logout"
    visit new_user_url
    fill_in "Username", with: "user2"
    fill_in "Password", with: "password"
    click_on "submit"
    visit user_url(User.find_by_username("user1"))
    expect(page).to have_content "my title"
  end
end
#
# feature "logging out" do
#
#   scenario "begins with a logged out state" do
#     visit users_url
#     expect(page).to have_content "Sign Up"
#     expect(page).to have_content "Sign In"
#     expect(page).to_not have_content "Welcome"
#   end
#
#   scenario "doesn't show username on the homepage after logout" do
#     visit new_user_url
#     fill_in "Username", with: "valid_username"
#     fill_in "Password", with: "valid_password"
#     click_on "submit"
#     click_on "Logout"
#     expect(page).to_not have_content "Welcome"
#   end
#
# end

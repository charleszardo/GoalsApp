require 'spec_helper'
require 'rails_helper'

feature "adding goals" do
  scenario "user is signed in" do
    sign_up_as("valid_username")
    add_goal("my title", "my body")
    expect(page).to have_content "my title"
  end

  scenario "user is not signed in" do
    visit new_goal_url
    expect(page).to have_content "All Users"
  end
end

feature "private goals" do
  before(:each) do
    sign_up_as("user1")
    add_goal("my title", "my body", "Private")
  end

  scenario "goal creator is signed in" do
    expect(page).to have_content "my title"
  end

  scenario "other user is signed in" do
    click_on "Logout"
    sign_up_as("user2")
    visit user_url(User.find_by_username("user1"))
    expect(page).to_not have_content "my title"
  end
end

feature "public goals" do
  before(:each) do
    sign_up_as("user1")
    add_goal("my title", "my body", "Public")
  end

  scenario "all users" do
    expect(page).to have_content "my title"
    click_on "Logout"
    sign_up_as("user2")
    visit user_url(User.find_by_username("user1"))
    expect(page).to have_content "my title"
  end
end

feature "completing goals" do
  before(:each) do
    sign_up_as("user1")
    add_goal("my title", "my body", "Public")
    click_on "my title"
  end

  scenario "status starts off incomplete" do
    expect(page).to have_content "incomplete"
  end

  scenario "status changes to complete" do
    click_on "complete goal"
    expect(page).to have_content "Status: complete"
  end

  scenario "status changes to incomplete" do
    click_on "complete goal"
    click_on "incomplete goal"
    expect(page).to_not have_content "Status: complete"
  end
end

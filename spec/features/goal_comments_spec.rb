require 'spec_helper'
require 'rails_helper'

feature "commenting" do
  before(:each) do
    visit new_user_url
    fill_in "Username", with: "user1"
    fill_in "Password", with: "password"
    click_on "submit"
    visit new_goal_url
    fill_in "Title", with: "comment title"
    fill_in "Body", with: "comment body"
    choose "Public"
    click_on "submit"
    click_on "Logout"
    visit new_user_url
    fill_in "Username", with: "user2"
    fill_in "Password", with: "password"
    click_on "submit"
  end

  scenario "comment on another users" do
    visit goal_url(Goal.find_by_title("comment title"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end

  scenario "comment on own goals" do
    click_on "Logout"
    visit new_session_url
    fill_in "Username", with: "user1"
    fill_in "Password", with: "password"
    click_on "submit"
    visit goal_url(Goal.find_by_title("comment title"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end
end

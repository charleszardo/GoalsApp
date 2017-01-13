require 'spec_helper'
require 'rails_helper'

feature "commenting" do
  before(:each) do
    sign_up_as("user1")
    visit new_goal_url
    add_goal("comment title", "comment body", "Public")
    click_on "Logout"
    sign_up_as("user2")
  end

  scenario "comment on another users" do
    visit goal_url(Goal.find_by_title("comment title"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end

  scenario "comment on own goals" do
    click_on "Logout"
    login_as("user1")
    visit goal_url(Goal.find_by_title("comment title"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end
end

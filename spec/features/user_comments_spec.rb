require 'spec_helper'
require 'rails_helper'

feature "commenting" do
  before(:each) do
    visit new_user_url
    fill_in "Username", with: "user1"
    fill_in "Password", with: "password"
    click_on "submit"
    click_on "Logout"
    visit new_user_url
    fill_in "Username", with: "user2"
    fill_in "Password", with: "password"
    click_on "submit"
  end

  scenario "comment on another user" do
    vist user_url(User.find_by_username("user1"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end

  scenario "comment on own page" do
    vist user_url(User.find_by_username("user2"))
    fill_in "Comment", with: "this is my comment"
    click_on "submit"
    expect(page).to have_content "this is my comment"
  end
end

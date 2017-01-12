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
    visit goal_url(Goal.find_by_title("comment title"))
  end

  feature "cheersing a goal" do
    scenario "user has cheers to give" do
      expect(page).to have_content("cheers: 0")
      click "cheers"
      expect(page).to have_content("comment_title")
      expect(page).to have_content("cheers: 1")
    end

    scenario "user is out of cheers" do
      13.times do
        click "cheers"
      end
      expect(page).to have_content("comment_title")
      expect(page).to have_content("cheers: 12")
    end
  end
end

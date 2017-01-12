require 'spec_helper'
require 'rails_helper'

feature "cheersing" do
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
      expect(page).to have_content("Cheers Remaining: 12")
      expect(page).to have_content("Cheers: 0")
      click_on "add cheers"
      expect(page).to have_content("comment title")
      expect(page).to have_content("Cheers Remaining: 11")
      expect(page).to have_content("Cheers: 1")
    end

    scenario "user is out of cheers" do
      12.times do
        click_on "add cheers"
      end
      expect(page).to_not have_content("cheers")
      expect(page).to have_content("Cheers: 12")
      expect(page).to have_content("Cheers Remaining: 0")
    end
  end
end

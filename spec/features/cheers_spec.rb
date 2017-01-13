require 'spec_helper'
require 'rails_helper'

feature "cheersing" do
  before(:each) do
    sign_up_as("user1")
    add_goal("comment title", "comment body", "Public")
    click_on "Logout"
    sign_up_as("user2")
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

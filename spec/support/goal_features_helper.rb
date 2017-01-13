module GoalFeaturesHelper
  def add_goal(title, body, public_private)
    visit new_goal_url
    fill_in "Title", with: title
    fill_in "Body", with: body
    choose public_private
    click_on "submit"
  end
end

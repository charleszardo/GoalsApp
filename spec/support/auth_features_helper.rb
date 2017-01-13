module AuthFeaturesHelper
  def sign_up_as(username, password="valid_password")
    visit new_user_url
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_on "submit"
  end

  def login_as(username, password="valid_password")
    visit new_session_url
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_button "submit"
  end
end

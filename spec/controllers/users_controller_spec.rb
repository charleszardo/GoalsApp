require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new users page" do
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of title and body" do
        post :create, user: {username: "invalid_user"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to the user show page" do
        post :create, user: {username: "valid_user", password: "abcdef"}
        user = User.find_by_username_and_password("valid_user", "abcdef")
        expect(response).to redirect_to(user_url(user))
      end
    end
  end

  describe "GET #show" do
    it "renders a user's show page" do
      user = User.create!(username: "valid_user", password: "abcdef")
      get :show, id: user.id

      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end
end

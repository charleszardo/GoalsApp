require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "GET #index" do
    it "renders the goals index page" do
      get :index

      expect(response).to render_template("index")
    end
  end
end

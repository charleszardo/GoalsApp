require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) do
    build(:user)
  end

  describe "password encryption" do
    it "does not save passwords to the database" do
      User.create!(username: "test_user", password: "abcdef")
      user = User.find_by_username("test_user")
      expect(user.password).not_to be("abcdef")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "test_user", password: "abcdef")
    end
  end

  describe "session_token" do
    it "ensures session token" do
      expect(user).to be_valid
      expect(user.session_token).to_not be_nil
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  # it { should have_many(:goals) }
end

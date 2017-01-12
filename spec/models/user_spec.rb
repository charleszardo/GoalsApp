require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) do
    build(:user)
  end

  describe "password encryption" do
    it "does not save passwords to the database" do
      User.create!(username: "test_userx", password: "abcdef")
      user = User.find_by_username("test_user")
      expect(user.password).not_to be("abcdef")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "test_user", password: "abcdef")
    end

    describe "#is_password?" do
      it "correctly determines if password belongs to user" do
        expect(user.is_password?(user.password)).to be true
        expect(user.is_password?("invalid_password")).to be false
      end
    end
  end

  describe "::find_by_username_and_password" do
    it "returns user when credentials are valid" do
      user = User.create!(username: "test_usery", password: "abcdef")
      expect(User.find_by_username_and_password(user.username, user.password)).to eq(user)
    end

    it "returns nil when credentials are invalid" do
      user = User.create!(username: "test_userz", password: "abcdef")
      expect(User.find_by_username_and_password(user.username, "invalid_password")).to be_nil
    end
  end

  describe "session_token" do
    it "ensures session token" do
      expect(user).to be_valid
      expect(user.session_token).to_not be_nil
    end

    it "resets session token" do
      original_token = user.session_token
      new_token = user.reset_session_token!
      expect(original_token).to_not eq(new_token)
      expect(user.session_token).to eq(new_token)
    end
  end

  describe "cheers" do
    describe "#has_remaining_cheers?" do
      it "returns true when cheers remain" do
        user = User.create!(username: "test_user1", password: "abcdef")
        expect(user.has_remaining_cheers?).to be true
      end

      it "returns false when no cheers remain" do
        user = User.create!(username: "test_user2", password: "abcdef", cheers_count: 0)
        expect(user.has_remaining_cheers?).to be false
      end
    end

    describe "#has_cheersed_goal" do
      it "determines if user has cheersed goal" do
        user1 = User.create!(username: "test_user3", password: "abcdef")
        user2 = User.create!(username: "test_user4", password: "abcdef")
        goal = Goal.create!(user_id: user1.id, title: "title")
        expect(user2.has_cheersed_goal?(goal)).to be false
        Cheer.create!(user: user2, goal: goal)
        expect(user2.has_cheersed_goal?(goal)).to be true
      end
    end

    describe "#cheers_goal" do
      it "reduces number of cheers by one" do
        user_cheers_count = user.cheers_count
        user.cheers_goal
        expect(user.cheers_count).to eq(user_cheers_count - 1)
      end
    end

    describe "#uncheers_goal" do
      it "increases number of cheers by one" do
        user_cheers_count = user.cheers_count
        user.uncheers_goal
        expect(user.cheers_count).to eq(user_cheers_count + 1)
      end
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should have_many(:goals) }
end

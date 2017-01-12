class UserComment < ActiveRecord::Base
  validates :user, :author, :body, presence: true

  belongs_to :user
  belongs_to :author, class_name: "User"
end

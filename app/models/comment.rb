class Comment < ActiveRecord::Base
  validates :author, :body, :commentable, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true
end

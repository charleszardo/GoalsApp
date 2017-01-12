class Goal < ActiveRecord::Base
  validates :user, :title, presence: true
  validates :public, :complete, inclusion: { in: [ true, false ] }

  belongs_to :user
  has_many :comments, class_name: "GoalComment"
end

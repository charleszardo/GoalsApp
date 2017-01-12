class Goal < ActiveRecord::Base
  include Commentable

  validates :user, :title, presence: true
  validates :public, :complete, inclusion: { in: [ true, false ] }

  belongs_to :user
end

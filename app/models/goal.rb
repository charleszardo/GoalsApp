class Goal < ActiveRecord::Base
  validates :user, :title, :public, :complete, presence: true

  belongs_to :user
end

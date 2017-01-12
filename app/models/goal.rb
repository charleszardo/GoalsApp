class Goal < ActiveRecord::Base
  include Commentable

  validates :user, :title, presence: true
  validates :public, :complete, inclusion: { in: [ true, false ] }

  belongs_to :user
  has_many :cheers

  def cheers_count
    Cheer.where(goal: self).count
  end
end

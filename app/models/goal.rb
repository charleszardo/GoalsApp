class Goal < ActiveRecord::Base
  include Commentable

  validates :user, :title, presence: true
  validates :public, :complete, inclusion: { in: [ true, false ] }

  belongs_to :user
  has_many :cheers

  def self.top_goals
    Goal.select("goals.*, COUNT(cheers.id) as cheers_count")
        .joins(:cheers)
        .group("goals.id")
        .limit(10)
        .order("cheers_count DESC")
  end

  def cheers_count
    Cheer.where(goal: self).count
  end
end

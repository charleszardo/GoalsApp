class Goal < ActiveRecord::Base
  include Commentable

  validates :user, :title, presence: true
  validates :public, :complete, inclusion: { in: [ true, false ] }

  belongs_to :user
  has_many :cheers

  def cheers_count
    Cheer.where(goal: self).count
  end

  def self.top_goals
    # Goal.select("goal.*, COUNT(cheers.id) as cheers_count")
    #     .joins(:cheers)
    #     .group(:goals)
    #     .limit(10)

    Goal.select("goals.*, COUNT(cheers.id) as cheers_count")
        .joins(:cheers)
        .group("goals.id")
        .limit(10)
        .order("cheers_count DESC")
  end
end

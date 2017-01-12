class Cheer < ActiveRecord::Base
  validates :user, :goal, presence: true

  belongs_to :user
  belongs_to :goal

  def self.create_cheers(user, goal)
    if user.has_remaining_cheers?
      Cheer.create!(user: user, goal: goal)
      user.cheers_goal
    end
  end

  def self.destroy_cheers(user, goal)
    if user.has_cheersed_goal?(goal)
      cheer = Cheer.find_by(user: user, goal: goal)
      cheer.destroy! if cheer
      user.uncheers_goal
    end
  end
end

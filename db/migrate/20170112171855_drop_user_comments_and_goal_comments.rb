class DropUserCommentsAndGoalComments < ActiveRecord::Migration
  def change
    drop_table :user_comments
    drop_table :goal_comments
  end
end

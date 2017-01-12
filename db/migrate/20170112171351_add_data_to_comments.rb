class AddDataToComments < ActiveRecord::Migration
  def change
    UserComment.find_each do |user_comment|
      Comment.create!(
        author_id: user_comment.author_id,
        body: user_comment.body,
        commentable_id: user_comment.user_id,
        commentable_type: "User"
      )
    end

    GoalComment.find_each do |goal_comment|
      Comment.create!(
        author_id: goal_comment.author_id,
        body: goal_comment.body,
        commentable_id: goal_comment.goal_id,
        commentable_type: "Goal"
      )
    end
  end
end

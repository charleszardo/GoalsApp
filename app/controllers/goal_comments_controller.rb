class GoalCommentsController < ApplicationController
  def create
    @comment = GoalComment.create(comment_params)
    @comment.goal_id = params[:goal_id]
    @comment.author = current_user
    @comment.save

    redirect_to goal_url(@comment.goal)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    if params[:user_id]
      @comment.commentable_id = params[:user_id]
      @comment.commentable_type = "User"
      redirect_url = user_url(params[:user_id])
    else
      @comment.commentable_id = params[:goal_id]
      @comment.commentable_type = "Goal"
      redirect_url = goal_url(params[:goal_id])
    end
    @comment.save

    redirect_to redirect_url
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

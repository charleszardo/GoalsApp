class UserCommentsController < ApplicationController
  def create
    @comment = UserComment.create(comment_params)
    @comment.user_id = params[:id]
    @comment.author = current_user
    @comment.save

    redirect_to user_show(@comment.user)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end

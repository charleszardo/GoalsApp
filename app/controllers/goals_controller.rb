class GoalsController < ApplicationController
  before_action :require_logged_in!

  def new
    @goal = Goal.new

    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    @goal.complete = false

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :body, :public)
  end
end

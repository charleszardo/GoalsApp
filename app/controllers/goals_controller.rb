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

  def show
    @goal = Goal.find(params[:id])

    render :show
  end

  def complete
    @goal = Goal.find(params[:id])
    @goal.complete = true
    @goal.save

    redirect_to goal_url(@goal)
  end

  def incomplete
    @goal = Goal.find(params[:id])
    @goal.complete = false
    @goal.save

    redirect_to goal_url(@goal)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :body, :public)
  end
end

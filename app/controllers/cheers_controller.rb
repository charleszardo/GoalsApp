class CheersController < ApplicationController
  def create
    if current_user.has_remaining_cheers?
      Cheer.create!(user: current_user, goal: params[:goal_id])
    end

    redirect_to goal_url(params[:goal_id])
  end

  def destroy
    if current_user.has_cheersed_goal?(params[:goal_id])
      cheer = Cheer.find_by_user_and_goal(user: current_user, goal: params[:goal_id])
      cheer.destroy!
    end

    redirect_to goal_url(params[:goal_id])
  end
end

class CheersController < ApplicationController
  def create
    Cheer.create_cheers(current_user, Goal.find(params[:goal_id]))

    redirect_to goal_url(params[:goal_id])
  end

  def destroy
    Cheer.destroy_cheers(current_user, Goal.find(params[:goal_id]))

    redirect_to goal_url(params[:goal_id])
  end
end

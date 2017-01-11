class SessionsController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_username_and_password(user_params[:username], user_params[:password])

    if @user
      login_user!(@user)
      redirect_to goals_url
    else
      flash[:errors] = "invalid credentials"
      render :new
    end
  end

  def destroy
    logout_user!(current_user) if current_user
    redirect_to goals_url
  end
end

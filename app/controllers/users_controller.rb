class UsersController < ApplicationController
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      login_user!(@user)
      redirect_to goals_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
end

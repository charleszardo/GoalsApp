class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def current_user
    session[:session_token] ? User.find_by_session_token(session[:session_token]) : nil
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def require_logged_in!
    redirect_to users_url unless logged_in?
  end
end

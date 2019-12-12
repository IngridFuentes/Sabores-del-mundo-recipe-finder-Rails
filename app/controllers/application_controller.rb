class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def logged_in?
    !!current_user
    # boolean
    # session.has_key? :user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # Marshal.load session[:user] if logged_in?
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end

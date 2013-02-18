class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user
  end
end
